#!/usr/bin/env bash

set -Eeuo pipefail

VM_NAME="Windows11"
VM_RAM_MIB="12288"
VM_VCPUS="8"
VM_DISK_SIZE="200G"

ISO_DIR="/data/VMs/iso"
IMAGE_DIR="/data/VMs/libvirt/images"

WINDOWS_ISO="${ISO_DIR}/Win11_25H2_German_x64_v2.iso"
VM_DISK="${IMAGE_DIR}/win11.qcow2"

die() {
    printf 'Fehler: %s\n' "$*" >&2
    exit 1
}

command -v virsh >/dev/null ||
die "virsh ist nicht installiert."

command -v virt-install >/dev/null ||
die "virt-install ist nicht installiert."

command -v qemu-img >/dev/null ||
die "qemu-img ist nicht installiert."

[[ -r "${WINDOWS_ISO}" ]] ||
die "Windows-ISO nicht gefunden: ${WINDOWS_ISO}"

VIRTIO_ISO="$(
    find "${ISO_DIR}" \
    -maxdepth 1 \
    -type f \
    -iname 'virtio*.iso' \
    -print \
    -quit
)"

[[ -n "${VIRTIO_ISO}" ]] ||
die "Keine VirtIO-ISO unter ${ISO_DIR} gefunden."

[[ -d "${IMAGE_DIR}" ]] ||
die "Image-Verzeichnis fehlt: ${IMAGE_DIR}"

if sudo virsh dominfo "${VM_NAME}" >/dev/null 2>&1; then
    die "Die VM ${VM_NAME} existiert bereits."
fi

if [[ -e "${VM_DISK}" ]]; then
    die "Die VM-Festplatte existiert bereits: ${VM_DISK}"
fi

printf 'Windows-ISO: %s\n' "${WINDOWS_ISO}"
printf 'VirtIO-ISO:  %s\n' "${VIRTIO_ISO}"
printf 'VM-Disk:     %s\n' "${VM_DISK}"

sudo qemu-img create \
-f qcow2 \
-o preallocation=metadata \
"${VM_DISK}" \
"${VM_DISK_SIZE}"

sudo virt-install \
--connect qemu:///system \
--name "${VM_NAME}" \
--metadata description="Windows 11 Home Homeoffice VM" \
--osinfo win11 \
--memory "${VM_RAM_MIB}" \
--vcpus "${VM_VCPUS}",sockets=1,cores=8,threads=1 \
--cpu host-passthrough \
--machine q35 \
--boot "loader=/usr/share/edk2/x64/OVMF_CODE.secboot.4m.fd,loader.readonly=yes,loader.type=pflash,loader_secure=yes,nvram.template=/usr/share/edk2/x64/OVMF_VARS.4m.fd" \
--features smm.state=on \
--tpm backend.type=emulator,backend.version=2.0,model=tpm-crb \
--controller type=scsi,model=virtio-scsi \
--disk "path=${VM_DISK},format=qcow2,bus=scsi,discard=unmap,cache=none,io=native" \
--cdrom "${WINDOWS_ISO}" \
--disk "path=${VIRTIO_ISO},device=cdrom,bus=sata,readonly=on" \
--network network=default,model=virtio \
--graphics spice,listen=none \
--video virtio \
--sound ich9 \
--channel spicevmc \
--channel unix,target.type=virtio,target.name=org.qemu.guest_agent.0 \
--rng /dev/urandom \
--memballoon virtio \
--noautoconsole

printf '\nVM wurde erstellt und gestartet.\n'
printf 'Anzeige öffnen mit:\n'
printf '  virt-viewer --connect qemu:///system %s\n' "${VM_NAME}"