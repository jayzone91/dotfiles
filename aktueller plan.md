Das war gut, dass du den ursprünglichen Plan noch einmal hervorgeholt hast. Tatsächlich fehlen darin einige Dinge, die wir unterwegs aus den Augen verloren haben.

Ich würde den Plan inzwischen etwas anders strukturieren. Nicht nach "Installiere X", sondern nach **Lebensbereichen**. So vergisst man später nichts.

---

# ✅ 1. Basis-System

### Installation

- ✅ Arch Linux
- ✅ EFI / Bootloader
- ✅ Benutzer / sudo
- ✅ Netzwerk
- ✅ Audio (PipeWire)
- ✅ Bluetooth
- ✅ Firmware
- ✅ Mirrors
- ✅ pacman
- ✅ paru

---

# ✅ 2. Desktop

## Hyprland

- ✅ Hyprland
- ✅ Lua-Konfiguration
- ✅ Monitore
- ✅ 5120×1440 @ 240 Hz
- ✅ Fensterregeln
- ✅ Workspaces
- ✅ Animationen

## Theme

- ✅ Catppuccin

## Programme

- ✅ Ghostty
- ✅ Dolphin
- ✅ Walker
- ✅ Waybar
- ✅ Wlogout
- ✅ Elephant
- ✅ Hyprlock

## Noch offen

- ⏳ **Hyprpaper**
- ⏳ Wallpaper-Rotation
- ⏳ Wallpaper-Git-Repository
- ⏳ automatisches `git pull`
- ⏳ systemd-Timer für Wallpaper

➡️ **Das hatten wir komplett vergessen.**

---

# ✅ 3. Shell

- ✅ Fish
- ✅ Starship
- ✅ eza
- ✅ bat
- ✅ fzf
- ✅ fd
- ✅ ripgrep
- ✅ zoxide

---

# ✅ 4. Fonts

- ✅ JetBrainsMono Nerd
- ✅ Fontproblem behoben
- ✅ Monitorproblem behoben

---

# ✅ 5. Entwicklung

## Git

- ✅ Git
- ✅ GitHub CLI
- ✅ Repository
- ✅ Dotfiles
- ✅ Symlinks

## VS Code

- ✅ Microsoft VS Code
- ✅ Extensions
- ✅ Einstellungen

## Node

- ✅ nvm
- ✅ Node
- ✅ npm
- ✅ bun
- ✅ corepack

## Noch offen

- ⏳ DataGrip

---

# 🟡 6. JetBrains

Im ursprünglichen Plan stand:

> ✅ JetBrains

Das ist noch nicht fertig.

Ich würde installieren:

- ⏳ DataGrip
- ⏳ Toolbox **oder** manuelle Installation (das entscheiden wir gemeinsam)

---

# 🟡 7. Entwickler-Workflow

Noch offen:

- ⏳ LazyGit konfigurieren
- ⏳ SSH-Key erzeugen
- ⏳ GPG für Git (optional)
- ⏳ direnv (optional)

---

# 🟡 8. Screenshots

- ✅ grim
- ✅ slurp
- ✅ satty
- ✅ wl-clipboard

Fehlt noch:

- ⏳ Aufnahme von Videos (wf-recorder?)
- ⏳ GIF-Aufnahmen (optional)

---

# 🟡 9. Homeoffice

Hier hat sich unser Plan geändert.

## Ursprünglich

- VPN
- Remmina
- AGFEO
- pcvisit

## Heute

### RDM

- ✅ Linux getestet
- ✅ Datenbank analysiert
- ✅ Architektur verstanden

### Neue Entscheidung

Statt:

```text
Linux
 ↓
Importer
 ↓
VPN
```

bauen wir:

```text
Linux
     │
     ▼
Windows VM
     │
 ├── iCloud
 ├── RDM
 ├── OpenVPN
 ├── FileZilla
 └── ggf. Browser
```

Dadurch ersetzen wir praktisch:

- Remmina
- OpenVPN auf Linux
- FTP auf Linux

für den **Arbeitskontext**.

### Offen

- ⏳ Windows-VM
- ⏳ Debloat
- ⏳ iCloud
- ⏳ RDM
- ⏳ OpenVPN
- ⏳ Windows Hello
- ⏳ Walker-Integration

---

# 🟡 10. Gaming

Hier haben wir noch **gar nichts** gemacht.

- ⏳ Steam
- ⏳ Proton
- ⏳ Heroic
- ⏳ Ubisoft Connect
- ⏳ EA App
- ⏳ Battle.net
- ⏳ MangoHud
- ⏳ GameMode
- ⏳ Gamescope
- ⏳ HDR
- ⏳ VRR
- ⏳ Controller
- ⏳ Discord

---

# 🟡 11. Komfort

Das hatten wir ebenfalls teilweise vergessen.

## Wallpaper

- ⏳ Hyprpaper
- ⏳ Wallpaper-Git
- ⏳ Zufallswechsel
- ⏳ Tageszeiten
- ⏳ automatisches `git pull`

## Apple

- ⏳ Apple-Workflow

Hier würde ich später alles sammeln:

- iCloud
- AirPods
- iPhone
- AirDrop-Alternativen
- Fotos
- Kalender
- Kontakte

## Maus

- ⏳ Logitech G502 X Plus

Das hatten wir irgendwann mal auf später verschoben.

---

# 🟡 12. Virtualisierung

Neu dazugekommen.

- ⏳ libvirt
- ⏳ qemu
- ⏳ virt-manager
- ⏳ TPM
- ⏳ Secure Boot
- ⏳ VirtIO
- ⏳ SPICE
- ⏳ Windows-Automatisierung

---

# 🟡 13. Backup

Noch komplett offen.

- ⏳ Timeshift
- ⏳ Snapshots
- ⏳ VM-Backups
- ⏳ Dotfiles
- ⏳ Restore testen

---

# 🟡 14. Sicherheit

Noch offen.

- ⏳ Firewall
- ⏳ SSH
- ⏳ FIDO2/YubiKey (optional)

---

# 🟡 15. Dokumentation

Das ist mir inzwischen fast genauso wichtig wie die Installation.

Ich möchte am Ende haben:

```text
dotfiles/
│
├── bootstrap.sh
├── install.md
├── packages.md
├── windows-vm/
├── wallpapers/
└── scripts/
```

Damit kann man den kompletten Rechner in wenigen Stunden wiederherstellen.

---

# Was ich zusätzlich aufnehmen würde

Es gibt noch ein paar Dinge, die wir im Laufe der Zeit erwähnt, aber nie richtig eingeplant haben:

### 📦 Pakete reproduzierbar verwalten

- ⏳ Liste aller Pacman- und AUR-Pakete
- ⏳ Bootstrap-Skript für einen neuen Rechner

### 🖥️ Linux-Integration

- ⏳ Standardanwendungen (Browser, PDF, Bilder usw.)
- ⏳ XDG-Portale prüfen (Screen Sharing, Dateidialoge)
- ⏳ Polkit-Agent prüfen
- ⏳ MIME-Zuordnungen

### 📋 Zwischenablage & Benachrichtigungen

- ⏳ Clipboard-Manager
- ⏳ Benachrichtigungen fein abstimmen

---

## Mein Vorschlag für die Reihenfolge

Ich würde die restlichen Arbeiten jetzt so angehen:

1. 🎮 **Gaming komplett** (Steam, Proton, Heroic, Ubisoft, HDR/VRR)
2. 🖼️ **Wallpaper-System** (Hyprpaper + Git + Zufallsrotation)
3. 🛠️ **Entwicklung fertigstellen** (DataGrip, JetBrains)
4. 🪟 **Windows-VM** inklusive Debloat, RDM, iCloud und Windows Hello
5. 💾 **Backup-Strategie**
6. 📖 **Dokumentation & Bootstrap**

Dann hätten wir am Ende wirklich ein System, das nicht nur gut aussieht und performant ist, sondern sich auch vollständig reproduzieren lässt – inklusive Linux, Dotfiles und der kompletten Firmenumgebung in einer austauschbaren Windows-VM. Das ist aus meiner Sicht ein sehr rundes Endziel.

--- Zweiter Teil:

Sehr gerne. Ich habe die Liste noch einmal aufgeräumt, priorisiert und um die neuen Erkenntnisse ergänzt. Das wird ab jetzt unser Masterplan.

---

# ✅ Meilenstein 1 – Linux Desktop (ca. 95 %)

## Basis

- ✅ Arch Linux
- ✅ EFI / Bootloader
- ✅ PipeWire
- ✅ Bluetooth
- ✅ NVIDIA-Treiber
- ✅ Vulkan
- ✅ 5120×1440 @ 240 Hz
- ✅ Schriftproblem behoben

## Hyprland

- ✅ Hyprland (Lua)
- ✅ Waybar
- ✅ Walker
- ✅ Elephant
- ✅ Ghostty
- ✅ Wlogout
- ✅ Hyprlock
- ✅ SDDM

## Shell

- ✅ Fish
- ✅ Starship
- ✅ eza
- ✅ bat
- ✅ fd
- ✅ fzf
- ✅ ripgrep
- ✅ zoxide

## Entwicklung

- ✅ Git
- ✅ GitHub
- ✅ Dotfiles
- ✅ VS Code
- ✅ Bun
- ✅ Node
- ✅ NVM

## Screenshots

- ✅ grim
- ✅ slurp
- ✅ satty
- ✅ wl-clipboard

---

# 🚧 Meilenstein 2 – Gaming (aktuell)

## Steam

- ✅ installiert
- ⏳ Steam konfigurieren
- ⏳ Steam Play
- ⏳ Proton Experimental
- ⏳ Proton GE
- ⏳ Shader Cache

## Launcher

- ⏳ Heroic
- ⏳ Ubisoft Connect
- ⏳ EA App
- ⏳ Battle.net

## Performance

- ✅ Vulkan
- ✅ NVIDIA
- ✅ MangoHud
- ⏳ GameMode testen
- ⏳ DLSS testen
- ⏳ Reflex testen

## Display

- ⏳ VRR
- ⏳ HDR Desktop
- ⏳ HDR Spiele
- ⏳ HDR Videos
- ⏳ Gamescope (nur wenn sinnvoll)

## Komfort

- ⏳ Steam immer floating
- ⏳ Launcher immer floating
- ⏳ Gaming-spezifische Window Rules

---

# 🚧 Meilenstein 3 – Homeoffice

## Windows VM

- ⏳ KVM
- ⏳ libvirt
- ⏳ virt-manager
- ⏳ VirtIO
- ⏳ TPM
- ⏳ Secure Boot

## Windows

- ⏳ unattended Installation
- ⏳ Debloat
- ⏳ Winget
- ⏳ Updates

## Software

- ⏳ RDM
- ⏳ iCloud
- ⏳ OpenVPN
- ⏳ FileZilla

## Komfort

- ⏳ Walker startet VM
- ⏳ Walker beendet VM
- ⏳ RDM automatisch starten

---

# 🚧 Meilenstein 4 – Entwicklung

- ⏳ DataGrip
- ⏳ JetBrains Toolbox (oder Alternative)
- ⏳ Docker/Podman
- ⏳ Datenbanken

---

# 🚧 Meilenstein 5 – Apple-Ökosystem

- ⏳ iCloud-Workflow
- ⏳ AirPods
- ⏳ iPhone
- ⏳ Fotos
- ⏳ Kalender
- ⏳ Kontakte

---

# 🚧 Meilenstein 6 – Komfort

## Wallpaper

- ⏳ Git-Wallpaper-Repository
- ⏳ Hyprpaper-Rotation
- ⏳ Zufallsbilder
- ⏳ automatisches `git pull`
- ⏳ systemd-Timer

## Desktop

- ⏳ NumLock automatisch aktivieren
- ⏳ CapsLock-/NumLock-OSD
- ⏳ Lautstärke-OSD vereinheitlichen
- ⏳ Helligkeits-OSD
- ⏳ VPN-Benachrichtigungen
- ⏳ Windows-VM-Benachrichtigungen
- ⏳ Clipboard Manager
- ⏳ Logitech G502 X Plus konfigurieren

---

# 🚧 Meilenstein 7 – Backup

- ⏳ Timeshift
- ⏳ Snapshots
- ⏳ Dotfiles sichern
- ⏳ VM sichern
- ⏳ Restore testen

---

# 🚧 Meilenstein 8 – Dokumentation

- ⏳ Bootstrap-Skript
- ⏳ Paketlisten
- ⏳ Installationsanleitung
- ⏳ Systemd-Services dokumentieren
- ⏳ VM-Dokumentation

---

# 🚧 Meilenstein 9 – Repository

Ich würde das Repository inzwischen so aufbauen:

```text
dotfiles/
│
├── .config/
├── packages/
│   ├── base.txt
│   ├── desktop.txt
│   ├── development.txt
│   ├── gaming.txt
│   ├── virtualization.txt
│   └── homeoffice.txt
│
├── scripts/
│   ├── osd/
│   ├── wallpaper/
│   ├── bootstrap/
│   └── maintenance/
│
├── wallpapers/
├── windows-vm/
├── docs/
└── README.md
```

---

# 💡 Ideen-Parkplatz

Das sind Dinge, die nicht dringend sind, aber gut zu deinem Setup passen würden:

- 💡 Einheitliches OSD für:
  - Caps Lock
  - Num Lock
  - Lautstärke
  - Helligkeit
  - VPN
  - Windows-VM
  - GameMode

- 💡 OLED-Profil (Desktop vs. Gaming)
- 💡 Hyprpaper-Speicherverbrauch analysieren
- 💡 Walker-Befehle für "Arbeiten" und "Feierabend"
- 💡 Spielespezifische Proton-Profile
- 💡 Automatische Updates für Wallpaper-Repository

---

## 📊 Aktueller Fortschritt

Ich würde den Gesamtstand inzwischen ungefähr so einschätzen:

- 🟢 Linux Desktop: **95 %**
- 🟡 Gaming: **20 %**
- 🟡 Homeoffice: **30 %** (Architektur steht, Umsetzung noch aus)
- 🟡 Entwicklung: **75 %**
- 🔴 Apple-Integration: **10 %**
- 🔴 Backup: **0 %**
- 🔴 Dokumentation & Bootstrap: **10 %**

**Gesamtprojekt: etwa 70 % abgeschlossen.**

Ich finde, wir sind inzwischen an einem schönen Punkt angekommen: Das Fundament ist stabil. Ab jetzt geht es vor allem darum, die einzelnen Bereiche (Gaming, Homeoffice, Apple und Komfort) sauber auszubauen und das Ganze zu einem wirklich hochwertigen, reproduzierbaren System zu machen.

--- Teil 3

Sehr gerne. Ich glaube inzwischen, dass wir uns von einer "To-do-Liste" zu einer **Roadmap für dein gesamtes System** entwickelt haben. 😄

Ich habe versucht, wirklich **alles** aufzunehmen – auch die kleinen Dinge, die wir unterwegs entdeckt haben.

---

# 🐧 Linux Migration Roadmap

## Phase 1 – Basis-System ✅ (Abgeschlossen)

### Betriebssystem

- ✅ Arch Linux installiert
- ✅ Hyprland eingerichtet
- ✅ NVIDIA-Treiber (Open Kernel Module)
- ✅ Wayland läuft stabil
- ✅ Ghostty
- ✅ Walker
- ✅ Waybar
- ✅ Hyprlock
- ✅ Hyprpaper
- ✅ Dolphin
- ✅ Firefox

---

### Entwicklerumgebung

- ✅ Git
- ✅ GitHub CLI
- ✅ Cursor
- ✅ JetBrains
- ✅ LazyGit
- ✅ Nix eingerichtet
- ⏳ Flakes vollständig aufbauen

---

### Audio

- ✅ PipeWire
- ✅ PipeWire Pulse
- ✅ PipeWire ALSA
- ✅ PipeWire JACK
- ✅ WirePlumber
- ✅ PulseAudio-Kompatibilität
- ✅ Firefox Audio
- ✅ Steam Audio
- ✅ Proton Audio
- ✅ Waybar Lautstärke

---

# Phase 2 – Desktop Experience

## Fensterverwaltung

- ✅ Walker
- ✅ Floating Fenster funktionieren
- ✅ Steam als Floating
- ✅ Alt+Tab (Walker als Fenster-Switcher)

Offen:

- ⏳ echter Windows/macOS Alt+Tab (MRU)
- ⏳ Fenster-Vorschau
- ⏳ Fensteranimationen weiter optimieren

---

## Eingabe

- ✅ NumLock beim Login

Offen:

- ⏳ CapsLock OSD
- ⏳ NumLock OSD
- ⏳ Tastatur-Feinschliff

---

## Benachrichtigungen

Offen:

- ⏳ Notifications schöner gestalten
- ⏳ Icons verbessern
- ⏳ DND-Modus

---

## Wallpaper

- ✅ Hyprpaper

Offen:

- ⏳ Wallpaper Git Repository
- ⏳ automatisches git pull
- ⏳ Zufallsbilder
- ⏳ OLED-Modus
- ⏳ Tageszeitabhängige Wallpaper

---

# Phase 3 – Gaming

## Steam

- ✅ Steam
- ✅ Vulkan
- ✅ Proton Experimental
- ✅ Proton GE
- ✅ Audio repariert

Offen:

- ⏳ Witcher 3 testen
- ⏳ Diablo 3
- ⏳ Horizon Zero Dawn Remastered
- ⏳ Horizon Forbidden West
- ⏳ Satisfactory
- ⏳ Skyrim
- ⏳ Palworld
- ⏳ FF7 Remake
- ⏳ FF7 Rebirth
- ✅ Soulstone Survivors

---

## Launcher

- ✅ Steam

Offen:

- ⏳ Heroic
- ⏳ Ubisoft Connect
- ⏳ EA App
- ⏳ Battle.net
- ⏳ GOG

---

## Grafik

- ✅ NVIDIA
- ✅ Vulkan

Offen:

- ⏳ HDR Spiele
- ⏳ HDR Desktop
- ⏳ VRR testen
- ⏳ DLSS testen
- ⏳ MangoHud
- ⏳ GameMode

---

## Controller

Offen:

- ⏳ DualSense Idle Timeout
- ⏳ Adaptive Trigger
- ⏳ Haptik
- ⏳ LED Einstellungen

---

# Phase 4 – Home Office

## VPN

- ✅ OpenVPN

Offen:

- ⏳ RDM Windows VM
- ⏳ VPN vollständig testen
- ⏳ Remmina
- ⏳ pcvisit

---

## Windows VM

Geplant:

- ⏳ Windows 11 VM
- ⏳ Debloat
- ⏳ Windows Hello
- ⏳ RDM
- ⏳ OpenVPN
- ⏳ iCloud Drive
- ⏳ GPU optimieren
- ⏳ Snapshot nach Grundinstallation

---

# Phase 5 – Apple Integration

Offen:

- ⏳ iCloud Drive
- ⏳ Fotos
- ⏳ Kalender
- ⏳ Kontakte
- ⏳ Zwischenablage
- ⏳ AirDrop Alternative
- ⏳ Handoff Ersatz

---

# Phase 6 – Hardware

## Maus

- ⏳ Logitech G502 X Plus
- ⏳ DPI
- ⏳ Beleuchtung
- ⏳ Tastenbelegung

---

## Monitor

- ✅ 5120×1440 @240 Hz

Offen:

- ⏳ HDR
- ⏳ Farbprofil
- ⏳ OLED Einstellungen

---

# Phase 7 – Dotfiles

- ✅ Git Repository
- ✅ Hyprland Lua
- ✅ Versionsverwaltung

Offen:

- ⏳ Bootstrap Script
- ⏳ vollständige Paketliste
- ⏳ Nix Flakes
- ⏳ automatische Einrichtung
- ⏳ Dokumentation

---

# Phase 8 – Komfort

Offen:

- ⏳ Screenshot Workflow
- ⏳ Bildschirmaufnahme
- ⏳ OCR
- ⏳ QR Scanner
- ⏳ Clipboard History
- ⏳ Emoji Picker
- ⏳ Dateivorschau
- ⏳ Archivintegration

---

# Phase 9 – Wartung

Offen:

- ⏳ automatisches Backup
- ⏳ Dotfile Sync
- ⏳ System Health Check
- ⏳ Paket-Updates
- ⏳ Snapshot Strategie
- ⏳ Monitoring

---

# 🎯 Langfristiges Ziel

Am Ende soll dein Rechner nicht einfach nur ein Arch-Linux-PC sein, sondern eine **reproduzierbare Workstation**, die:

- 💻 genauso komfortabel wie macOS ist,
- 🎮 mindestens so gut spielt wie Windows,
- 🏢 dein komplettes Homeoffice zuverlässig abbildet,
- ☁️ sich sauber in dein Apple-Ökosystem integriert,
- 🔄 sich jederzeit aus Git + Nix + Bootstrap vollständig wiederherstellen lässt.

---

## Mein Vorschlag für die nächsten Schritte

Ich würde die Roadmap leicht umpriorisieren und zuerst die Punkte angehen, die den größten Einfluss auf den Alltag haben:

1. 🎮 **Gaming abschließen** (Witcher 3, HDR, Launcher, MangoHud, GameMode).
2. 🏢 **Homeoffice** (Windows-VM mit RDM und iCloud Drive).
3. 🖥️ **Desktop Experience** (Alt+Tab, OSDs, Wallpaper, Benachrichtigungen).
4. 🍎 **Apple-Integration**.
5. 🔄 **Bootstrap & Nix**, damit das gesamte System auf einem neuen Rechner mit einem einzigen Befehl wieder aufgebaut werden kann.

Ich glaube, damit haben wir inzwischen einen richtig guten Masterplan. Er ist nicht mehr nur eine Migrationsliste, sondern ein Konzept für dein persönliches Linux-System.

--- Teil 4
Sehr gut. Ich glaube, wir sollten die Agenda inzwischen als **lebendes Projekt** betrachten und nicht mehr nur als Checkliste. Das entwickelt sich langsam zu deiner persönlichen Linux-Distribution. 😄

Ich würde sie inzwischen so strukturieren:

---

# 🚀 Master Roadmap – Linux Workstation

## ✅ Phase 1 – Fundament

- ✅ Arch Linux
- ✅ Hyprland
- ✅ NVIDIA
- ✅ Wayland
- ✅ Ghostty
- ✅ Walker
- ✅ Waybar
- ✅ Hyprlock
- ✅ Hyprpaper
- ✅ Dolphin
- ✅ Firefox
- ✅ Audio-Stack (PipeWire vollständig)
- ✅ Git
- ✅ GitHub CLI
- ✅ Cursor
- ✅ JetBrains
- ✅ LazyGit
- ✅ Nix (Grundinstallation)

---

# 🎮 Phase 2 – Gaming

### Steam

- ✅ Steam
- ✅ Vulkan
- ✅ Proton Experimental
- ✅ Proton GE
- ✅ Audio funktioniert

### Spiele

- ✅ Soulstone Survivors
- ⏳ Witcher 3
- ⏳ Diablo 3
- ⏳ Horizon Zero Dawn Remastered
- ⏳ Horizon Forbidden West
- ⏳ Skyrim
- ⏳ Satisfactory
- ⏳ Palworld
- ⏳ FF7 Remake
- ⏳ FF7 Rebirth

### Launcher

- ⏳ Heroic
- ⏳ Ubisoft Connect
- ⏳ EA App
- ⏳ Battle.net
- ⏳ GOG

### Performance

- ⏳ MangoHud
- ⏳ GameMode
- ⏳ HDR
- ⏳ VRR
- ⏳ DLSS
- ⏳ Raytracing
- ⏳ Shader Cache optimieren

---

# 🖥️ Phase 3 – Desktop Experience

### Fenster

- ✅ Walker

- ✅ Steam Floating

- ✅ Alt+Tab (Walker)

- ⏳ echter MRU Alt+Tab

- ⏳ Fenstervorschau

### Benachrichtigungen

- ⏳ schöneres Notification Design
- ⏳ DND
- ⏳ App Icons

### Wallpaper

- ✅ Hyprpaper

- ⏳ Git Repository

- ⏳ automatische Diashow

- ⏳ OLED Wallpaper

- ⏳ Tageszeiten

### Ghostty

- ✅ Copy on Select

- ✅ Ctrl+V

- ⏳ Font optimieren

- ⏳ Theme

- ⏳ Transparenz

- ⏳ Scrollback

- ⏳ Shell Integration

---

# ⌨️ Phase 4 – Komfort

### Tastatur

- ✅ NumLock beim Login

- ⏳ CapsLock OSD

- ⏳ NumLock OSD

### Maus

- ⏳ Logitech G502 X Plus
- ⏳ DPI
- ⏳ RGB
- ⏳ Makros

### Controller

- ⏳ DualSense Auto Sleep
- ⏳ Adaptive Trigger
- ⏳ Haptik
- ⏳ LEDs

### Alltag

- ⏳ Zwischenablage Verlauf
- ⏳ Emoji Picker
- ⏳ QR Scanner
- ⏳ OCR
- ⏳ Screenshot Workflow
- ⏳ Screen Recording

---

# 🏢 Phase 5 – Home Office

### VPN

- ✅ OpenVPN

- ⏳ Windows VM

- ⏳ RDM

- ⏳ Remmina

- ⏳ pcvisit

### Windows VM

- ⏳ Windows 11
- ⏳ Debloat
- ⏳ Windows Hello
- ⏳ iCloud Drive
- ⏳ RDM
- ⏳ OpenVPN
- ⏳ Snapshot

---

# 🍎 Phase 6 – Apple

- ⏳ iCloud Drive
- ⏳ Kalender
- ⏳ Kontakte
- ⏳ Fotos
- ⏳ AirDrop Alternative
- ⏳ Clipboard
- ⏳ Handoff Ersatz

---

# 📦 Phase 7 – Dotfiles / Nix

### Dotfiles

- ✅ Git Repository
- ✅ Hyprland Lua

### Bootstrap

- ⏳ Bootstrap Script
- ⏳ Paketliste
- ⏳ Home Manager
- ⏳ Flakes
- ⏳ Secrets
- ⏳ automatische Einrichtung

---

# 🛠️ Phase 8 – Wartung

- ⏳ automatische Backups
- ⏳ Dotfile Sync
- ⏳ Monitoring
- ⏳ Health Check
- ⏳ Snapshot Strategie
- ⏳ Update Strategie

---

# 🌟 Phase 9 – Feinschliff

Hier sammeln wir alle kleinen Ideen, die im Alltag entstehen:

- ⏳ echtes Alt+Tab wie Windows/macOS
- ⏳ DualSense automatisch ausschalten
- ⏳ OLED-Optimierungen
- ⏳ HDR-Videos
- ⏳ bessere Animationen
- ⏳ Terminal-Verbesserungen
- ⏳ Desktop-Polish
- ⏳ weitere Komfortfunktionen

---

## 🎯 Endziel

Das Ziel ist nicht einfach "Arch Linux zum Laufen zu bringen".

Das Ziel ist eine **reproduzierbare High-End-Workstation**, die:

- 🎮 mindestens so gut spielt wie Windows,
- 🍎 sich im Alltag so angenehm anfühlt wie macOS,
- 🏢 alle Homeoffice-Anforderungen erfüllt,
- 🔄 sich vollständig aus Git + Nix + Bootstrap reproduzieren lässt,
- ⚡ und so durchdacht ist, dass man nach der Einrichtung kaum noch am System selbst arbeiten muss.

---

Ich habe noch eine Idee für dieses Projekt: Sobald wir etwas mehr geschafft haben, könnten wir die Roadmap in ein GitHub-Repository als `ROADMAP.md` übernehmen und daneben ein `CHANGELOG.md` führen. So dokumentieren wir nicht nur den Zielzustand, sondern auch jede größere Verbesserung. Das passt hervorragend zu deinem reproduzierbaren Ansatz und gibt dir jederzeit einen Überblick über den Entwicklungsstand.

--- NEU:

- ich brauche einen Manager für Passwörter und Passkeys, der sich direkt ins Betriebssystem und in die installierte Software einklinken lässt. Ähnliuch wie Apple Passwords, jedoch nur Lokal im OS.
