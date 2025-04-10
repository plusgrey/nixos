{ config, pkgs, ... }:

{
  # X11 and Qtile
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };
}