{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    space-station-14-launcher
    nix-gaming.osu-stable
    xwaylandvideobridge
    stable-2305.freecad
    gradient-generator
    prismlauncher
    prusa-slicer
    xivlauncher
    starsector
    godot-mono
    openscad
  ];

  services.flatpak.packages = [
    "flathub:app/net.retrodeck.retrodeck/x86_64/stable"
  ];
  
}