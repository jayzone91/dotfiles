# Dotfiles

Dieses Repository enthält meine Konfigurationen für eine Arch-Linux-Workstation mit Hyprland und weiteren Werkzeugen. Die Konfigurationen werden zentral über Bootstrap-Skripte installiert und verlinkt.

## Überblick

Das Repo ist in drei Bereiche gegliedert:

- .config: enthält die eigentlichen Konfigurationsdateien für Anwendungen wie Hyprland, Waybar, Ghostty, Neovim und mehr.
- bootstrap: installiert Pakete, richtet Symlinks ein und aktiviert Dienste.
- packages: definiert die Pakete für pacman und AUR in einer zentralen YAML-Datei.

## Repository-Struktur

```text
dotfiles/
├── .config/
├── bootstrap/
│   ├── bootstrap.sh
│   ├── install-pacman.sh
│   ├── install-paru.sh
│   ├── install-aur.sh
│   ├── link-dotfiles.sh
│   ├── enable-services.sh
│   └── lib/common.sh
├── packages/
│   └── packages.yaml
├── emoji-additional.csv
└── README.md
```

## Voraussetzungen

Die Bootstrap-Skripte sind primär für Arch Linux ausgelegt. Auf einem frischen System wird zuerst `yq` benötigt, damit die Paketliste gelesen werden kann:

```bash
sudo pacman -S --needed yq
```

## Erste Installation

Im Repository-Root ausführen:

```bash
./bootstrap/bootstrap.sh
```

Der Ablauf umfasst:

1. Installation der pacman-Pakete aus `packages/packages.yaml`
2. Installation von `paru` aus dem AUR
3. Installation der AUR-Pakete
4. Verlinken der Konfigurationsordner aus `.config` nach `~/.config`
5. Aktivieren von System- und User-Services

## Hinweise

- Die Skripte sind weitgehend idempotent: bereits installierte Pakete, bestehende Symlinks und aktivierte Services werden nicht mehrfach unnötig verändert.
- Bestehende Dateien oder Ordner werden bei der Verlinkung gesichert, falls sie bereits existieren.
- Die Windows-Variante über `install.ps1` ist noch ein Work-in-Progress und sollte derzeit nicht verwendet werden.
