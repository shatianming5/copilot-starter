#!/usr/bin/env bash

set -u

COPILOT_DIR="${COPILOT_HOME:-$HOME/.copilot}"
PASS=0
FAIL=0
WARN=0

pass() {
  printf 'PASS  %s\n' "$1"
  PASS=$((PASS + 1))
}

fail() {
  printf 'FAIL  %s\n' "$1"
  FAIL=$((FAIL + 1))
}

warn() {
  printf 'WARN  %s\n' "$1"
  WARN=$((WARN + 1))
}

if command -v copilot >/dev/null 2>&1; then
  pass "Copilot CLI is installed: $(command -v copilot)"
else
  fail "Copilot CLI is not installed"
fi

instruction="$COPILOT_DIR/instructions/starter.instructions.md"
if [ -s "$instruction" ]; then
  pass "starter instructions are installed"
else
  fail "missing $instruction"
fi

for name in debugging-basics review-basics simplify-basics; do
  skill="$COPILOT_DIR/skills/$name/SKILL.md"
  if [ -s "$skill" ] \
     && grep -q '^name:' "$skill" \
     && grep -q '^description:' "$skill"; then
    pass "skill $name is installed"
  else
    fail "missing or invalid $skill"
  fi
done

settings="$COPILOT_DIR/settings.json"
if [ -s "$settings" ]; then
  if command -v python3 >/dev/null 2>&1; then
    if python3 -m json.tool "$settings" >/dev/null 2>&1; then
      pass "settings.json is valid JSON"
    else
      fail "settings.json is invalid JSON"
    fi
  elif command -v node >/dev/null 2>&1; then
    if node -e 'JSON.parse(require("fs").readFileSync(process.argv[1], "utf8"))' \
      "$settings" >/dev/null 2>&1; then
      pass "settings.json is valid JSON"
    else
      fail "settings.json is invalid JSON"
    fi
  else
    warn "could not validate settings.json because Python and Node are unavailable"
  fi
else
  fail "missing $settings"
fi
printf '\n%d passed, %d failed, %d warnings\n' "$PASS" "$FAIL" "$WARN"
[ "$FAIL" -eq 0 ]
[ "$FAIL" -eq 0 ]
