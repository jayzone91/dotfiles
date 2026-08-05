#!/usr/bin/env bash

set -Eeuo pipefail
export LC_ALL=C

VM_NAME="Windows11"
CONNECTION="qemu:///system"

BOOT_TIMEOUT=180
REBOOT_TIMEOUT=180

VIEWER_PATTERN="virt-viewer.*${VM_NAME}"
VIEWER_LOG="${XDG_CACHE_HOME:-${HOME}/.cache}/windows11-viewer.log"

notify() {
    notify-send \
    --app-name="Homeoffice" \
    --icon=computer \
    "$1" \
    "${2:-}"
}

vm_state() {
    virsh \
    --connect "${CONNECTION}" \
    domstate "${VM_NAME}" 2>/dev/null |
    tr -d '\r' |
    xargs
}

viewer_running() {
    pgrep -u "${USER}" -f "${VIEWER_PATTERN}" >/dev/null
}

guest_agent_ready() {
    virsh \
    --connect "${CONNECTION}" \
    qemu-agent-command \
    "${VM_NAME}" \
    '{"execute":"guest-ping"}' >/dev/null 2>&1
}

wait_for_guest_agent() {
    local timeout="$1"
    local elapsed=0
    
    while ((elapsed < timeout)); do
        if guest_agent_ready; then
            return 0
        fi
        
        sleep 2
        ((elapsed += 2))
    done
    
    return 1
}

wait_for_guest_agent_disconnect() {
    local timeout="$1"
    local elapsed=0
    
    while ((elapsed < timeout)); do
        if ! guest_agent_ready; then
            return 0
        fi
        
        sleep 1
        ((elapsed += 1))
    done
    
    return 1
}

start_viewer() {
    if viewer_running; then
        return 0
    fi
    
    mkdir -p "$(dirname "${VIEWER_LOG}")"
    
    virt-viewer \
    --connect "${CONNECTION}" \
    --wait \
    --attach \
    --reconnect \
    "${VM_NAME}" >"${VIEWER_LOG}" 2>&1 &
    
    disown
}

reboot_windows() {
    virsh \
    --connect "${CONNECTION}" \
    qemu-agent-command \
    "${VM_NAME}" \
    '{
            "execute": "guest-exec",
            "arguments": {
                "path": "C:\\Windows\\System32\\shutdown.exe",
                "arg": ["/r", "/t", "0", "/f"],
                "capture-output": true
            }
    }' >/dev/null
}

if ! virsh \
--connect "${CONNECTION}" \
dominfo "${VM_NAME}" >/dev/null 2>&1; then
    
    notify \
    "Windows-VM nicht gefunden" \
    "${VM_NAME} ist nicht definiert."
    
    exit 1
fi

state="$(vm_state)"

case "${state}" in
    running)
        start_viewer
        notify \
        "Homeoffice läuft" \
        "Windows 11 ist bereits gestartet."
        exit 0
    ;;
    
    paused)
        virsh \
        --connect "${CONNECTION}" \
        resume "${VM_NAME}" >/dev/null
        
        start_viewer
        
        notify \
        "Homeoffice fortgesetzt" \
        "Windows 11 wurde fortgesetzt."
        
        exit 0
    ;;
    
    "shut off")
    ;;
    
    *)
        notify \
        "Unbekannter VM-Status" \
        "${state}"
        
        exit 1
    ;;
esac

notify \
"Homeoffice wird gestartet" \
"Windows 11 fährt hoch."

# Wichtig: Der Viewer wartet bereits, bevor die VM startet.
start_viewer

sleep 1

if ! virsh \
--connect "${CONNECTION}" \
start "${VM_NAME}" >/dev/null; then
    
    notify \
    "Start fehlgeschlagen" \
    "Windows 11 konnte nicht gestartet werden."
    
    exit 1
fi

notify \
"Windows 11 startet" \
"Warte auf den ersten Systemstart."

if ! wait_for_guest_agent "${BOOT_TIMEOUT}"; then
    notify \
    "Start unvollständig" \
    "Der Guest Agent antwortet nach ${BOOT_TIMEOUT} Sekunden nicht."
    
    exit 1
fi

# Kleine Verzögerung, damit Windows nach dem Start des Guest Agents
# noch Dienste und den Desktop initialisieren kann.
sleep 8

notify \
"Anzeige wird vorbereitet" \
"Windows 11 wird einmal neu gestartet."

if ! reboot_windows; then
    notify \
    "Neustart fehlgeschlagen" \
    "Windows konnte nicht automatisch neu gestartet werden."
    
    exit 1
fi

# Zuerst muss der Agent durch den Neustart verschwinden.
if ! wait_for_guest_agent_disconnect 60; then
    notify \
    "Neustart nicht erkannt" \
    "Der Guest Agent wurde nicht getrennt."
    
    exit 1
fi

# Danach auf den zweiten Windows-Start warten.
if ! wait_for_guest_agent "${REBOOT_TIMEOUT}"; then
    notify \
    "Neustart unvollständig" \
    "Windows antwortet nach dem Neustart nicht."
    
    exit 1
fi

notify \
"Homeoffice bereit" \
"Windows 11 ist gestartet und die Anzeige wurde initialisiert."