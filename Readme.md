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
Install GUI Applications (Read more about these in [GUI Applications](#GUI))

```bash
brew install --cask \
    alfred \
    ghostty \
    github \
    setapp \
    tunnelblick
```

Install terminal applications (read more about these in (Terminal Applications)[#TerminalApplications])

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

- Alfred (Spotlight replacement)
- Ghostty (Terminal replacement)
- Github (Github Client)
- SetApp (Alternative Marketplace for Premium Apps)
- Tunnelblick (VPN Client)


## Terminal Applications

- asdf
- cmake
- eza
- gh
- go
- nvm
- pnpm
- ripgrep
- spaceship
- stow
- gettext
- curl

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
