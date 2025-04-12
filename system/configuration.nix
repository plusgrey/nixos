{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./packages.nix
    ./fonts.nix
    ./display.nix
    ./vpn.nix
  ];

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Asia/Singapore";

  #extra options
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User account
  users.users.jh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # State version
  system.stateVersion = "24.11";
}
