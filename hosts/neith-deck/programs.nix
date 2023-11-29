{ pkgs, ... }:
{

  programs.steam.package = pkgs.steam-original-fixed;
  environment.systemPackages = with pkgs; [
    starsector-gamescope-wrap
    steam-deck-client
    prismlauncher
    xivlauncher
  ];

  services.flatpak.packages = [
    "flathub:app/net.retrodeck.retrodeck/x86_64/stable"
  ];

}