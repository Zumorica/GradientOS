{ pkgs, ... }:

{

  fonts = {
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      hinting = {
        enable = true;
        autohint = true;
      };
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Source Sans Pro" ];
        serif = [ "Source Serif Pro" ];
        emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
      };
    };
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      twemoji-color-font
      source-code-pro
      source-sans-pro
      source-serif-pro
      google-fonts
      fira
      fira-mono
      fira-code
      fira-code-symbols
      corefonts
    ];
  };

}