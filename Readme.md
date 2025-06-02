# Install Routine on MacOS

## System Preferences

NYI

## Brew Install

Install [Homebrew](https://brew.sh/) as package Manager for MacOS:

```bash
# paste in terminal an follow the instructions
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Update everything in Homebrew to recent Version

```bash
brew update
```

Install GUI Applications (Read more about these in [GUI Applications](#gui-applications))

```bash
brew install --cask \
    alfred \
    ghostty \
    github \
    setapp \
    tunnelblick
```

Install terminal applications (read more about these in [Terminal Applications](#terminal-applications))

```bash
brew install --formulae \
    asdf \
    cmake \
    eza \
    gh \
    go \
    ninja \
    nvm \
    pnpm \
    ripgrep \
    spaceship \
    stow \
    gettext \
    curl
```

## Install Neovim

Clone Neovim Repository

```bash
git clone https://github.com/neovim/neovim
```

If you want the _stable release_, also run `git checkout stable`.

```bash
cd neovim
```

```bash
make CMAKE_BUILD_TYPE=RelWithDebInfo
```

```bash
sudo make install
```

## Gui Applications

- [Alfred](https://www.alfredapp.com) (Spotlight replacement)
- [Ghostty](https://ghostty.org) (Terminal replacement)
- [Github](https://github.com/apps/desktop) (Github Client)
- [SetApp](https://setapp.com/de) (Alternative Marketplace for Premium Apps)
- [Tunnelblick](https://tunnelblick.net) (VPN Client)

## Terminal Applications

- [asdf](https://asdf-vm.com)
- [cmake](https://cmake.org)
- [eza](https://eza.rocks)
- [gh](https://cli.github.com)
- [go](https://go.dev)
- [nvm](https://github.com/nvm-sh/nvm)
- [pnpm](https://pnpm.io)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [spaceship](https://starship.rs)
- [stow](https://www.gnu.org/software/stow/)
- [gettext](https://www.gnu.org/software/gettext/)
- [curl](https://curl.se)

## Oh My Zsh

NYI

## Stow

Clone Dotfiles repo

```bash
git clone https://github.com/jayzone91/dotfiles
```

`cd dotfiles` and `make all`

Restart Ghostty, omz should autoinstall all plugins.

Now open `nvim` to install and configure all Plugins
