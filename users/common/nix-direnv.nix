{ pkgs, ... }:

{

  home.file.".config/direnv/direnvrc".text =
''
source ${pkgs.nix-direnv}/direnvrc
'';

}