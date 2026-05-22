#!/usr/bin/env bash
# LLM Provider Pulse — Config Validation Tests
set -euo pipefail

PULSE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROVIDERS_FILE="$PULSE_DIR/scripts/providers.json"
PASS=0
FAIL=0

green() { echo -e "\033[32m✓ $1\033[0m"; }
red()   { echo -e "\033[31m✗ $1\033[0m"; }

echo "=== LLM Provider Pulse — Config Tests ==="
echo ""

# Test 1: providers.json exists and is valid JSON
if [ -f "$PROVIDERS_FILE" ]; then
  if python3 -c "import json; json.load(open('$PROVIDERS_FILE'))" 2>/dev/null; then
    green "providers.json is valid JSON"
    PASS=$((PASS+1))
  else
    red "providers.json is invalid JSON"
    FAIL=$((FAIL+1))
  fi
else
  red "providers.json not found"
  FAIL=$((FAIL+1))
fi

# Test 2: providers count
COUNT=$(python3 -c "import json; d=json.load(open('$PROVIDERS_FILE')); print(len(d.get('providers',[])))" 2>/dev/null)
if [ "$COUNT" -ge 30 ]; then
  green "Provider count: $COUNT (>= 30)"
  PASS=$((PASS+1))
else
  red "Provider count: $COUNT (< 30, too few)"
  FAIL=$((FAIL+1))
fi

# Test 3: all providers have required fields
MISSING=$(python3 -c "
import json
d=json.load(open('$PROVIDERS_FILE'))
missing=[]
for p in d.get('providers',[]):
    for field in ['name','category','endpoint','affiliate_url']:
        if not p.get(field):
            missing.append(f'{p.get(\"name\",\"?\")} missing {field}')
print('\n'.join(missing))
" 2>/dev/null)
if [ -z "$MISSING" ]; then
  green "All providers have required fields"
  PASS=$((PASS+1))
else
  red "Missing fields:\n$MISSING"
  FAIL=$((FAIL+1))
fi

# Test 4: scripts exist and are executable
for script in "health-check.sh" "latency-test.sh" "feedback.py"; do
  if [ -f "$PULSE_DIR/scripts/$script" ]; then
    green "scripts/$script exists"
    PASS=$((PASS+1))
  else
    red "scripts/$script missing"
    FAIL=$((FAIL+1))
  fi
done

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
exit $FAIL
