#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib/common.sh
source "$SCRIPT_DIR/lib/common.sh"

ROOT=$(repo_root)
PACKAGES_FILE=${PACKAGES_FILE:-"$ROOT/packages/packages.yaml"}

[[ -f "$PACKAGES_FILE" ]] || die "Package file not found: $PACKAGES_FILE"
command_exists yq || die "yq is required. Install it first with: sudo pacman -S --needed yq"

mapfile -t packages < <(
  yq -r '
    .packages
    | to_entries[]
    | .value[]
    | select(.source == "pacman" and (.required // true) == true)
    | .package
  ' "$PACKAGES_FILE" | sort -u
)

((${#packages[@]} > 0)) || die "No required pacman packages found in $PACKAGES_FILE"

log "Installing ${#packages[@]} pacman packages"
sudo pacman -S --needed --noconfirm "${packages[@]}"
