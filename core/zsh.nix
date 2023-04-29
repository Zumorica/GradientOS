{ pkgs, ... }:

{

  programs.zsh.enable = true;

  environment.pathsToLink = [ "/share/zsh" ];

  environment.shells = with pkgs; [
    zsh 
  ]; 

}