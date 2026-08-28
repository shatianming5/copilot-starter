#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COPILOT_DIR="${COPILOT_HOME:-$HOME/.copilot}"
STAMP="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0

case "${1:-}" in
  "") ;;
  --dry-run) DRY_RUN=1 ;;
  -h|--help)
    printf 'Usage: %s [--dry-run]\n' "$0"
    exit 0
    ;;
  *)
    printf 'Unknown option: %s\n' "$1" >&2
    exit 2
    ;;
esac

say() {
  printf '  %s\n' "$*"
}

ensure_dir() {
  local path="$1"
  if [ "$DRY_RUN" -eq 1 ]; then
    say "would create $path"
  else
    mkdir -p "$path"
  fi
}

install_file() {
  local source="$1"
  local destination="$2"

  if [ -f "$destination" ] && cmp -s "$source" "$destination"; then
    say "unchanged $destination"
    return
  fi

  if [ "$DRY_RUN" -eq 1 ]; then
    [ -e "$destination" ] && say "would back up $destination"
    say "would install $destination"
    return
  fi

  mkdir -p "$(dirname "$destination")"
  if [ -e "$destination" ]; then
    cp -p "$destination" "$destination.pre-copilot-starter-$STAMP"
    say "backed up $destination"
  fi
  cp -p "$source" "$destination"
  say "installed $destination"
}

install_skill() {
  local source="$1"
  local name
  local destination

  name="$(basename "$source")"
  destination="$COPILOT_DIR/skills/$name"

  if [ -d "$destination" ] && diff -qr "$source" "$destination" >/dev/null; then
    say "unchanged skill $name"
    return
  fi

  if [ "$DRY_RUN" -eq 1 ]; then
    [ -e "$destination" ] && say "would back up $destination"
    say "would install skill $name"
    return
  fi

  mkdir -p "$COPILOT_DIR/skills"
  if [ -e "$destination" ]; then
    cp -R "$destination" "$destination.pre-copilot-starter-$STAMP"
    say "backed up skill $name"
  fi
  mkdir -p "$destination"
  cp -R "$source/." "$destination/"
  say "installed skill $name"
}

printf 'Copilot Starter installer\n'
printf 'Target: %s\n' "$COPILOT_DIR"
[ "$DRY_RUN" -eq 1 ] && printf 'DRY RUN - no files will change\n'

ensure_dir "$COPILOT_DIR/instructions"
ensure_dir "$COPILOT_DIR/skills"

install_file \
  "$ROOT/copilot/instructions/starter.instructions.md" \
  "$COPILOT_DIR/instructions/starter.instructions.md"

for skill in "$ROOT"/copilot/skills/*; do
  [ -d "$skill" ] && install_skill "$skill"
done

if [ -e "$COPILOT_DIR/settings.json" ]; then
  say "kept existing $COPILOT_DIR/settings.json"
  say "starter settings remain at $ROOT/copilot/settings.json"
else
  install_file "$ROOT/copilot/settings.json" "$COPILOT_DIR/settings.json"
fi

printf '\nDone.\n'
printf 'Start Copilot with: copilot\n'
printf 'Authenticate inside Copilot with: /login\n'
printf 'Inspect loaded configuration with: /instructions and /skills\n'
