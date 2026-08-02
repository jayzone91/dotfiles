#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib/common.sh
source "$SCRIPT_DIR/lib/common.sh"

if command_exists paru; then
  log "paru is already installed"
  exit 0
fi

command_exists git || die "git is required to bootstrap paru"
command_exists makepkg || die "makepkg is required. Install base-devel first"

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

log "Building paru from the AUR"
git clone --depth=1 https://aur.archlinux.org/paru.git "$TMP_DIR/paru"
cd "$TMP_DIR/paru"
makepkg -si --noconfirm
