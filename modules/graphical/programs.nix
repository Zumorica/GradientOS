{ pkgs, ... }:

{

  programs.chromium.enable = true;
  programs.partition-manager.enable = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.filelight
  ];

}