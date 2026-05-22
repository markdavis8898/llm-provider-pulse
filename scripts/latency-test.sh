#!/usr/bin/env bash
# ============================================================
# LLM Provider Pulse — Latency Test
# Measures detailed latency stats for each provider endpoint
# ============================================================
set -euo pipefail

PULSE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROVIDERS_FILE="$PULSE_DIR/scripts/providers.json"
RESULTS_DIR="$PULSE_DIR/data/results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
REPORT_FILE="$RESULTS_DIR/latency_$TIMESTAMP.json"

mkdir -p "$RESULTS_DIR"

echo "========================================"
echo " LLM Provider Pulse — Latency Test"
echo " $(date)"
echo "========================================"

python3 -c "
import json, subprocess, time

with open('$PROVIDERS_FILE') as f:
    data = json.load(f)

results = []
for p in data.get('providers', []):
    name = p.get('name', 'unknown')
    endpoint = p.get('endpoint', '')
    
    if not endpoint:
        continue
    
    # Run 3 pings for each provider
    latencies = []
    for i in range(3):
        try:
            start = time.time()
            subprocess.run(
                ['curl', '-s', '-o', '/dev/null', '-w', '%{http_code}',
                 '--connect-timeout', '3', '--max-time', '8', endpoint],
                capture_output=True, text=True, timeout=10
            )
            elapsed = round((time.time() - start) * 1000, 1)
            latencies.append(elapsed)
        except:
            pass
    
    if latencies:
        avg = round(sum(latencies) / len(latencies), 1)
        _min = min(latencies)
        _max = max(latencies)
        print(f'{name:25} min={_min:>6}ms  avg={avg:>6}ms  max={_max:>6}ms  (samples={len(latencies)})')
    else:
        avg = _min = _max = -1
        print(f'{name:25} ❌ unreachable')
    
    results.append({
        'name': name,
        'latency_ms': {'min': _min, 'avg': avg, 'max': _max, 'samples': len(latencies)}
    })

print(f'\\nTested {len(results)} providers.')
print(json.dumps({'timestamp': time.strftime(\"%Y-%m-%dT%H:%M:%SZ\", time.gmtime()), 'results': results}))
" > "$REPORT_FILE"

echo ""
echo "Report saved: $REPORT_FILE"
