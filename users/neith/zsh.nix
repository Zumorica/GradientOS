{ config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    historySubstringSearch.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
    };
    initExtra = builtins.readFile ./zshrc;
  };

}