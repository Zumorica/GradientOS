{ pkgs, ... }:
{

  programs.steam.package = pkgs.steam-original-fixed;
  environment.systemPackages = with pkgs; [
    steam-deck-client
    prismlauncher
    moonlight-qt
    dolphin-emu
    xivlauncher
    heroic
  ];

  services.flatpak.packages = [
  ];

}