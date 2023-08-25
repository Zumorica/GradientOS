{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    wineWowPackages.stagingFull
    winetricks
  ];

}