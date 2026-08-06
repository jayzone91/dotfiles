# 🚀 Linux Workstation Roadmap

> Ziel: Eine reproduzierbare High-End-Workstation für Gaming, Entwicklung und Homeoffice, die sich jederzeit vollständig aus Git + Bootstrap + Nix wiederherstellen lässt.

---

# 🏁 Projekt-Meilensteine

## ✅ M1 – Fundament (Abgeschlossen)

Eine stabile Linux-Basis.

### Betriebssystem

- ✅ Arch Linux
- ✅ Hyprland
- ✅ Waybar
- ✅ Hyprlock
- ✅ Hyprpaper
- ✅ Ghostty

### Audio

- ✅ PipeWire
- ✅ WirePlumber
- ✅ PulseAudio Compatibility

### Entwicklung

- ✅ Git
- ✅ GitHub CLI
- ✅ Cursor
- ✅ VS Code
- ✅ JetBrains
- ✅ Bun
- ✅ Node
- ✅ NVM
- ✅ Nix

### Desktop

- ✅ Walker
- ✅ ALT+F4
- ✅ Fullscreen Rescue
- ⏳ Steam Floating

---

## 🟢 M2 – Gaming (Aktuell)

Ziel:

> Windows vollständig ersetzen.

### Plattformen

- ✅ Steam
- ✅ Battle.net
- ✅ Heroic
- ✅ Ubisoft Connect
- ✅ EA App
- ✅ GOG

---

### Gaming Stack

- ✅ Proton GE
- ✅ MangoHud
- ✅ GameMode
- ⏳ HDR
- ⏳ VRR
- ⏳ DLSS
- ⏳ Shader Cache

---

### Spiele

- ✅ Witcher 3
- 🟡 Diablo III
- ⏳ Horizon Zero Dawn Remastered
- ⏳ Horizon Forbidden West
- ⏳ Skyrim
- ⏳ Palworld
- ⏳ Satisfactory
- ⏳ FF7 Remake
- ⏳ FF7 Rebirth

---

## 🟡 M3 – Produktivität

Ziel:

> Linux wird Hauptarbeitsplatz.

### Desktop

- ⏳ Generelles ALT+TAB (Walker wird nicht mehr als App-Launcher genutzt; dafür kommt Fuzzel zum Einsatz)
- ⏳ Windows-ähnliches ALT+TAB
- ⏳ Fenstervorschau
- ⏳ Animationen
- ✅ Einheitliches OSD

### Terminal

- ✅ Ghostty
- ✅ Copy on Select
- ✅ Ctrl+V
- ⏳ Shell Integration


### Komfort

- ✅ Passwortmanager
- ✅ Clipboard History
- ✅ Emoji Picker
- 🟡 Logitech G502 X Plus
  - Maus RGB läuft noch nicht korrekt
- ⏳ Controller Auto Sleep
- ⏳ Keybind Cheatsheet

---

### Homeoffice

- ✅ OpenVPN

#### Windows VM

- ✅ libvirt
- ✅ virt-manager
- ✅ Windows 11
- ✅ VirtIO
- ✅ TPM
- ✅ Secure Boot
- ✅ Snapshot
- ✅ Windows Hello
- ✅ Remote Desktop Manager
- ✅ FileZilla
- ✅ iCloud Drive
- ⏳ Debloat
- ⏳ Installationsskript für die komplette Windows-Software
- 🚀 VirtIO-FS (gemeinsamer Ordner ohne Samba)
- 🎮 Gaming-/Feierabend-Modus verfeinern
- 📊 Waybar-Widget für den VM-Status
- 🪟 Hyprland-Integration (Workspace/Fensterposition)
- 📸 Snapshot-Verwaltung
- 🧹 Eigenes Windows-Optimierungsskript
Die Virtualisierung soll im Dotfiles-Repository modularisiert werden, damit sie denselben Qualitätsstandard wie der Rest der Konfiguration erreicht. Nach einem frischen Arch-Setup soll sich die komplette Homeoffice-Umgebung mit einem einzigen Bootstrap-Skript wiederherstellen lassen.

---

### Apple

- ⏳ iCloud
- ⏳ Fotos
- ⏳ Kalender
- ⏳ Kontakte
- ⏳ AirPods
- ⏳ AirDrop Alternative
- ⏳ Handoff Alternative

---

## 🔴 M4 – Reproduzierbarkeit

Ziel:

> Neuinstallation in unter einer Stunde.

### Bootstrap

- ✅ Nix (Multi-User)
- ✅ Flakes
- ✅ Home Manager
- ✅ Modulstruktur (`common`, `shell`, `desktop`)
- ✅ Formatter mit `nix fmt`
- ✅ Flake-Checks
- ✅ `just`-Workflow
- 🟡 Desktop-Migration
- ⏳ Development-Migration
- ⏳ bootstrap.sh
- ⏳ Paketlisten

### Bereits über Home Manager verwaltet

#### Common

- ✅ Git
- ✅ Delta
- ✅ CLI-Tools
- ✅ Session-Umgebung
- ✅ PATH-Bereinigung

#### Shell

- ✅ Fish
- ✅ Starship
- ✅ FZF
- ✅ Zoxide
- ✅ Aliases und Abbreviations

#### Desktop

- ✅ Ghostty

---

### Backup

- ⏳ Timeshift
- ⏳ Restore Test
- ⏳ Snapshot Strategie
- ⏳ Dotfile Sync
- ⏳ VM Backup
- ⏳ Health Check
- ⏳ Monitoring
- ⏳ Update Strategie

---

### Dokumentation

- ⏳ INSTALL.md
- ⏳ CHANGELOG.md
- ✅ ROADMAP.md

#### Gaming

- ✅ Steam
- ✅ Battle.net
- ✅ Witcher 3
- ✅ Diablo III

#### Troubleshooting

- ✅ PipeWire
- ✅ Battle.net
- ✅ Diablo III
- ✅ Hyprland

---

# 📊 Gesamtfortschritt

| Bereich            | Status  |
| ------------------ | :-----: |
| Fundament          | ✅ 100 % |
| Gaming             | 🟢 75 %  |
| Produktivität      | 🟡 55 %  |
| Reproduzierbarkeit | 🟡 35 %  |

---

# 📝 Bekannte Einschränkungen

## Diablo III

- ✅ Läuft stabil im Borderless Window
- Exklusiver Maus-/Tastatur-Grab bleibt nach Verlassen des Fullscreens bestehen.
- Soulstone Survivors ist nicht betroffen.
- Vermutlich Wine-/Diablo-III-spezifisch.
- Vorerst zurückgestellt.

---

# 💡 Ideen-Parkplatz

- OLED Profile
- HDR Workflow
- Performance Profile
- Gaming Dashboard
- Wallpaper Automation
- Einheitliches OSD
- Proton Profile pro Spiel

---

# 🧩 Nix-Migration

Ziel:

> Eine vollständig deklarative Benutzerumgebung auf Arch Linux, ohne Wechsel zu NixOS.

## Architektur

- ✅ Arch Linux bleibt das Basissystem.
- ✅ Systemnahe Pakete und Dienste bleiben zunächst bei Pacman und systemd.
- ✅ Benutzerpakete und Konfigurationen werden schrittweise durch Nix und Home Manager verwaltet.
- ✅ Die Flake ist modular in `common`, `shell` und `desktop` aufgebaut.
- ✅ Windows bleibt eine schlanke Homeoffice-VM und wird weiterhin über Winget, Scoop und PowerShell automatisiert.

## Bereits migriert

### Common

- ✅ Git
- ✅ Delta
- ✅ CLI-Pakete
- ✅ Session-Variablen
- ✅ PATH-Verwaltung

### Shell

- ✅ Fish
- ✅ Starship
- ✅ FZF
- ✅ Zoxide
- ✅ Shell-Abbreviations

### Desktop

- ✅ Ghostty

### Infrastruktur

- ✅ `flake.nix`
- ✅ `flake.lock`
- ✅ Home-Manager-Host für `jay`
- ✅ `nix fmt`
- ✅ `nix flake check`
- ✅ `justfile`
- ✅ Home-Manager-Generationen und Rollbacks

## Nächste Schritte

### Theme

- ⏳ Zentrales Catppuccin-Modul
- ⏳ Gemeinsame Farben
- ⏳ Gemeinsame Fonts
- ⏳ Gemeinsame Größen und Abstände

### Desktop

- ⏳ Fastfetch
- ⏳ Btop
- ⏳ Hyprland
- ⏳ Waybar
- ⏳ Hyprlock
- ⏳ Hypridle
- ⏳ Hyprpaper
- ⏳ SwayNC
- ⏳ Fuzzel
- ⏳ Wlogout

### Development

- ⏳ Neovim
- ⏳ Direnv
- ⏳ Node
- ⏳ Bun
- ⏳ Go
- ⏳ Rust
- ⏳ Python

### Services

- ⏳ Logitech-Battery-Service
- ⏳ Wallpaper-Automation
- ⏳ Desktop-Dateien
- ⏳ Homeoffice-Skripte
- ⏳ Weitere User-Services

### Langfristig

- ⏳ Vollständiger Bootstrap
- ⏳ Bereinigung der Pacman-/AUR-Paketlisten
- ⏳ Restore-Test auf einem frischen Arch-System
- ⏳ Dokumentation der Migration
- ⏳ Gemeinsame Automatisierung für Arch und Windows-VM

---

# 🎯 Vision

Eine Linux-Workstation, die:

- 🎮 Windows beim Gaming ersetzt.
- 💻 macOS beim Entwickeln ersetzt.
- 🏢 den kompletten Homeoffice-Alltag übernimmt.
- 🍎 sich sinnvoll in das Apple-Ökosystem integriert.
- 🔄 jederzeit vollständig reproduzierbar ist.

# TODO
- Standardprogramme in Dolphin hinterlegen, damit dort Dateien direkt geöffnet werden können.
- Anmeldebildschirm überarbeiten, der sieht nicht aus!
- Aktuellen freien Speicher beider SSDs in Waybar anzeigen  
- Favoritenleiste zum Starten von Anwendungen, ähnlich wie unter macOS