{ pkgs, ... }:
{

  programs.steam.package = pkgs.steam-original-fixed;
  environment.systemPackages = with pkgs; [
    steam-deck-client
    prismlauncher
    dolphin-emu
    xivlauncher
    heroic
  ];

  services.flatpak.packages = [
    "flathub:app/net.retrodeck.retrodeck/x86_64/stable"
    "flathub:app/com.moonlight_stream.Moonlight/x86_64/stable"
  ];

}