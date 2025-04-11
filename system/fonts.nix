{ config, pkgs, ... }:

{
  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    fonts = with pkgs; [
      maple-mono.Normal-NF-CN
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      jetbrains-mono
    ];
  };

  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [
        "Maple Mono Normal NF CN"
        "JetBrains Mono"
      ];
      sansSerif = [
        "Noto Sans CJK SC"
        "Source Han Sans SC"
      ];
      serif = [
        "Noto Serif CJK SC"
        "Source Han Serif SC"
      ];
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
    ];
  };
}