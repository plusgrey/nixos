{ config, pkgs, ... }:

{
  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    alacritty
    git
    btop
    nemo
    rofi
    home-manager
  ];
}