{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    space-station-14-launcher
    xwaylandvideobridge
    gradient-generator
    stable.freecad
    osu-lazer-bin
    prismlauncher
    prusa-slicer
    dolphin-emu
    mullvad-vpn
    xivlauncher
    openscad
    heroic
  ];

  services.flatpak.packages = [
    "flathub:app/net.retrodeck.retrodeck/x86_64/stable"
    # "flathub:app/com.moonlight_stream.Moonlight/x86_64/stable"
  ];
  
}