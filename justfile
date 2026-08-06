set shell := ["fish", "-c"]

default:
    @just --list

check:
    nix flake check

switch:
    home-manager switch --flake .#jay

build:
    nix build .#homeConfigurations.jay.activationPackage

fmt:
    nix fmt

update:
    nix flake update

news:
    home-manager news

generations:
    home-manager generations

diff:
    home-manager generations
    @echo
    @echo "Aktuelle Git-Änderungen:"
    git status --short

clean:
    nix-collect-garbage -d

clean-system:
    sudo nix-collect-garbage -d

verify:
    just fmt
    just check

rebuild:
    just check
    just switch