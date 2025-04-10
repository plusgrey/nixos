{ config, pkgs, ... }:

{
  home.username = "jh";
  home.homeDirectory = "/home/jh";

  # User-specific packages
  home.packages = with pkgs; [
    tree
    vscode
    fastfetch
    wechat-uos
    firefox
    zip
    unzip
  ];

  home.stateVersion = "24.11";
}