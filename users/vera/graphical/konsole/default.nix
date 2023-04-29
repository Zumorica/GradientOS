{ config, pkgs, ... }:

{

  home.file = {
    ".local/share/konsole/vera.colorscheme".source = ./vera.colorscheme;
    ".local/share/konsole/vera.profile".source = ./vera.profile;
    ".config/konsolerc".source = ./konsolerc;
  };

}