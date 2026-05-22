#!/usr/bin/env bash
# ============================================================
# LLM Provider Pulse — Health Check Runner
# Tests connectivity and response time for all configured LLM providers
# ============================================================
set -euo pipefail

PULSE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROVIDERS_FILE="$PULSE_DIR/scripts/providers.json"
RESULTS_DIR="$PULSE_DIR/data/results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
REPORT_FILE="$RESULTS_DIR/pulse_$TIMESTAMP.json"

mkdir -p "$RESULTS_DIR"

echo "========================================"
echo " LLM Provider Pulse — Health Check"
echo " $(date)"
echo "========================================"

if [ ! -f "$PROVIDERS_FILE" ]; then
  echo "ERROR: providers.json not found at $PROVIDERS_FILE"
  exit 1
fi

# Count providers
TOTAL=$(python3 -c "import json; d=json.load(open('$PROVIDERS_FILE')); print(len(d.get('providers',[])))")
echo "Providers to check: $TOTAL"
echo ""

RESULTS='{"timestamp":"'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'","results":[]}'

python3 -c "
import json, subprocess, sys, socket, time, ssl
from datetime import datetime

with open('$PROVIDERS_FILE') as f:
    data = json.load(f)

results = []
for p in data.get('providers', []):
    name = p.get('name', 'unknown')
    endpoint = p.get('endpoint', '')
    category = p.get('category', 'api')
    
    status = 'unknown'
    latency = -1
    error = ''
    
    if endpoint and endpoint.startswith('http'):
        try:
            start = time.time()
            req = subprocess.run(
                ['curl', '-s', '-o', '/dev/null', '-w', '%{http_code}', 
                 '--connect-timeout', '5', '--max-time', '10', endpoint],
                capture_output=True, text=True, timeout=15
            )
            latency = round((time.time() - start) * 1000, 1)
            code = req.stdout.strip()
            if code in ['200','201','401','403']:
                # 401/403 means endpoint exists but requires auth = alive
                status = 'reachable'
            else:
                status = 'responding'
            error = f'HTTP {code}'
        except subprocess.TimeoutExpired:
            status = 'timeout'
            error = 'Connection timed out'
        except Exception as e:
            status = 'error'
            error = str(e)[:80]
    
    result = {
        'name': name,
        'category': category,
        'status': status,
        'latency_ms': latency,
        'error': error,
        'checked_at': datetime.utcnow().isoformat()
    }
    results.append(result)
    
    icon = '✅' if status == 'reachable' else '⚠️' if status == 'responding' else '❌'
    lat_str = f'{latency}ms' if latency > 0 else 'N/A'
    print(f\"{icon} {name:25} {status:12} latency={lat_str:8} {error}\")

print(f'\\n---\\nChecked {len(results)} providers.')
print(json.dumps({'timestamp': datetime.utcnow().isoformat(), 'results': results}))
" > "$REPORT_FILE"

echo ""
echo "Report saved: $REPORT_FILE"
echo "========================================"
