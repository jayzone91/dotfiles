# Bootstrap skeleton

Copy this structure into the root of the dotfiles repository.

## Expected layout

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
└── packages/
    └── packages.yaml
```

Add this entry to `packages/packages.yaml`:

```yaml
packages:
  bootstrap:
    - package: yq
      source: pacman
      reason: Parse packages.yaml for bootstrap scripts
      required: true
```

## First run

`yq` is needed before the YAML can be parsed, so install it once on a fresh system:

```bash
sudo pacman -S --needed yq
./bootstrap/bootstrap.sh
```

All scripts are idempotent where practical: `pacman`, `paru`, existing symlinks, and enabled services can be run repeatedly.
