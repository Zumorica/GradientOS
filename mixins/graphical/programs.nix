{ pkgs, ... }:

{

  programs.partition-manager.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.filelight
  ];

}