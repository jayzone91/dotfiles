#!/usr/bin/env bash

set -Eeuo pipefail

VM_NAME="Windows11"
CONNECTION="qemu:///system"
SHUTDOWN_TIMEOUT=120
VIEWER_PATTERN="virt-viewer.*${VM_NAME}"

notify() {
    notify-send \
    --app-name="Homeoffice" \
    --icon=system-shutdown \
    "$1" \
    "${2:-}"
}

vm_state() {
    LC_ALL=C virsh \
    --connect "${CONNECTION}" \
    domstate "${VM_NAME}" 2>/dev/null |
    tr -d '\r' |
    xargs
}

if ! virsh --connect "${CONNECTION}" dominfo "${VM_NAME}" >/dev/null 2>&1; then
    notify "Windows-VM nicht gefunden" "${VM_NAME} ist nicht definiert."
    exit 1
fi

state="$(vm_state)"

case "${state}" in
    "shut off")
        pkill -u "${USER}" -f "${VIEWER_PATTERN}" 2>/dev/null || true
        notify "Bereits Feierabend" "Windows 11 ist bereits ausgeschaltet."
        exit 0
    ;;
    
    paused)
        virsh --connect "${CONNECTION}" resume "${VM_NAME}"
    ;;
    
    running)
    ;;
    
    *)
        notify "Herunterfahren nicht möglich" "Aktueller Status: ${state}"
        exit 1
    ;;
esac

notify "Feierabend wird vorbereitet" "Windows 11 wird sauber heruntergefahren."

# Der Agent-Modus fordert Windows direkt zum regulären Herunterfahren auf.
if ! virsh \
--connect "${CONNECTION}" \
shutdown "${VM_NAME}" \
--mode agent; then
    notify "Herunterfahren fehlgeschlagen" "Der QEMU Guest Agent antwortet nicht."
    exit 1
fi

if virsh \
--connect "${CONNECTION}" \
await "${VM_NAME}" \
--condition domain-inactive \
--timeout "${SHUTDOWN_TIMEOUT}" >/dev/null 2>&1; then
    
    pkill -u "${USER}" -f "${VIEWER_PATTERN}" 2>/dev/null || true
    
    notify "Feierabend 🍺" "Windows 11 ist vollständig ausgeschaltet."
    exit 0
fi

notify \
"Windows fährt noch herunter" \
"Nach ${SHUTDOWN_TIMEOUT} Sekunden läuft die VM weiterhin. Sie wurde nicht hart ausgeschaltet."

exit 1