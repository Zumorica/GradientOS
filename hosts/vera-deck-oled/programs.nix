{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    space-station-14-launcher
    prismlauncher
    wl-clipboard
    dolphin-emu
    xivlauncher
    heroic
  ];

  services.flatpak.packages = [
    "flathub:app/net.retrodeck.retrodeck/x86_64/stable"
    "flathub:app/com.moonlight_stream.Moonlight/x86_64/stable"
  ];

}