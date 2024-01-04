{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    space-station-14-launcher
    xwaylandvideobridge
    stable-2305.freecad
    gradient-generator
    jetbrains.rider
    osu-lazer-bin
    prismlauncher
    prusa-slicer
    dolphin-emu
    xivlauncher
    godot-mono
    unityhub
    openscad
    heroic
  ];

  services.flatpak.packages = [
    "flathub:app/net.retrodeck.retrodeck/x86_64/stable"
  ];
  
}