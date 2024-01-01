{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    space-station-14-launcher
    prismlauncher
    dolphin-emu
    xivlauncher
  ];

  services.flatpak.packages = [
    "flathub:app/net.retrodeck.retrodeck/x86_64/stable"
  ];

}