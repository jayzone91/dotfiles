#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib/common.sh
source "$SCRIPT_DIR/lib/common.sh"

system_services=(
  NetworkManager.service
  bluetooth.service
  sddm.service
)

user_services=(
  pipewire.socket
  pipewire-pulse.socket
  wireplumber.service
)

log "Enabling system services"
for service in "${system_services[@]}"; do
  sudo systemctl enable "$service"
done

log "Enabling user services"
for service in "${user_services[@]}"; do
  systemctl --user enable "$service" 2>/dev/null || warn "Could not enable $service yet"
done

log "Enabling virtualization services"
sudo systemctl enable --now libvirtd.service
systemctl status libvirtd --no-pager
sudo virsh net-start default
sudo virsh net-autostart default
mkdir -p /data/VMs/libvirt/images
mkdir -p /data/VMs/iso
sudo chattr +C /data/VMs/libvirt/images
lsattr -d /data/VMs/libvirt/images
sudo virsh pool-define-as \
  --name data-vms \
  --type dir \
  --target /data/VMs/libvirt/images

sudo virsh pool-build data-vms
sudo virsh pool-start data-vms
sudo virsh pool-autostart data-vms

