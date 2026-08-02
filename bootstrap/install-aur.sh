#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib/common.sh
source "$SCRIPT_DIR/lib/common.sh"

ROOT=$(repo_root)
PACKAGES_FILE=${PACKAGES_FILE:-"$ROOT/packages/packages.yaml"}

[[ -f "$PACKAGES_FILE" ]] || die "Package file not found: $PACKAGES_FILE"
command_exists yq || die "yq is required"
command_exists paru || die "paru is required. Run bootstrap/install-paru.sh first"

mapfile -t packages < <(
  yq -r '
    .packages
    | to_entries[]
    | .value[]
    | select(.source == "aur" and (.required // true) == true)
    | .package
  ' "$PACKAGES_FILE" | sort -u
)

((${#packages[@]} > 0)) || {
  log "No required AUR packages found"
  exit 0
}

log "Installing ${#packages[@]} AUR packages"
paru -S --needed --noconfirm "${packages[@]}"
