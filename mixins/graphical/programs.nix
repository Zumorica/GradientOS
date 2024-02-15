{ pkgs, ... }:

{

  programs.partition-manager.enable = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.filelight
  ];

}