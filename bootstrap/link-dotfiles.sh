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

# Link logitech-battery script
ln -s "$ROOT/scripts/logitech-battery" "$HOME/.local/bin/logitech-battery"

ln -s "$ROOT/services/logitech-battery.service" "$HOME/.config/systemd/user/logitech-battery.service"
ln -s "$ROOT/services/logitech-battery.timer" "$HOME/.config/systemd/user/logitech-battery.timer"

# Start logitech-battery service
systemctl --user daemon-reload
if command -v systemctl &> /dev/null; then
  systemctl --user enable --now logitech-battery.timer || warn "Failed to enable logitech-battery.timer"
fi
