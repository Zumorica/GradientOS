{ pkgs, ... }:
{

  programs.nushell = {
    enable = true;
    package = pkgs.nushellFull;
    extraConfig = ''
      $env.config = {
        show_banner: false
      }
    '';
  };

  programs.carapace.enableNushellIntegration = true;
  programs.direnv.enableNushellIntegration = true;

}