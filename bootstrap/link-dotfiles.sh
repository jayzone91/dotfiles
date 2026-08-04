#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib/common.sh
source "$SCRIPT_DIR/lib/common.sh"

ROOT=$(repo_root)
SOURCE="$ROOT/.config"
TARGET="$HOME/.config"

[[ -d "$SOURCE" ]] || die "No .config directory found at $SOURCE"
mkdir -p "$TARGET"

log "Linking dotfiles from $SOURCE"
for path in "$SOURCE"/*; do
  [[ -e "$path" ]] || continue
  name=$(basename "$path")
  target="$TARGET/$name"

  if [[ -e "$target" || -L "$target" ]]; then
    if [[ -L "$target" && "$(readlink -f "$target")" == "$(readlink -f "$path")" ]]; then
      log "$name is already linked"
      continue
    fi
    backup="$target.backup.$(date +%Y%m%d-%H%M%S)"
    warn "$target exists; moving it to $backup"
    mv "$target" "$backup"
  fi

  ln -s "$path" "$target"
  log "Linked $name"
done

# Link german emoji
mkdir -p "$HOME/.local/share/rofimoji"
ln -s "$ROOT/emoji-additional.csv" "$HOME/.local/share/rofimoji/emoji-additional.csv"