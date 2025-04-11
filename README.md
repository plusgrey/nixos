# nixos

Minimal Nix-OS configuration with flake

## Requirement

Minimal NixOS Installation

## Install

Manually copy the `/etc/hardware-configuration.nix` to `./system/`

Change the hostname in (`flake.nix, system/configuration.nix`) as well as the username in (`home/user.nix`)

Run: `sudo nixos-rebuild switch --flake .`