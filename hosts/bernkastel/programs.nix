{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    gradient-generator
    stable.freecad
    prusa-slicer
    mullvad-vpn
    openscad
  ];

  services.flatpak.packages = [
    # "flathub:app/com.moonlight_stream.Moonlight/x86_64/stable"
  ];
  
}