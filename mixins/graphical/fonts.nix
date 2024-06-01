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
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      twemoji-color-font
      source-code-pro
      source-sans-pro
      source-serif-pro
      google-fonts
      nerdfonts
      fira
      fira-mono
      fira-code
      fira-code-symbols
      unifont
      corefonts
      ubuntu_font_family
    ];
  };

}