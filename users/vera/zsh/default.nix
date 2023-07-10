{ ... }:

{

  imports = [
    ../../../modules/home/zsh.nix
  ];
  
  programs.zsh.initExtra = builtins.readFile ./zshrc;

}