#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib/common.sh
source "$SCRIPT_DIR/lib/common.sh"

steps=(
  install-pacman.sh
  install-paru.sh
  install-aur.sh
  link-dotfiles.sh
  enable-services.sh
)

for step in "${steps[@]}"; do
  log "Running $step"
  "$SCRIPT_DIR/$step"
done

log "Bootstrap completed"
