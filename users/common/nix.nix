{ osConfig, ... }:
{

  nix.registry = osConfig.nix.registry;

  home.sessionVariables.NIX_PATH = (builtins.concatStringsSep ":" osConfig.nix.nixPath);

}