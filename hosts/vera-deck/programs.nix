{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    starsector-gamescope-wrap
    space-station-14-launcher
    nix-gaming.osu-stable
    gradient-generator
    prismlauncher
    xivlauncher
  ];

  services.flatpak.packages = [
    "flathub:app/net.retrodeck.retrodeck/x86_64/stable"
  ];

}