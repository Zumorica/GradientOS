{ config, ... }:
let
  nix-pub-keys = import ../../misc/nix-pub-keys.nix;
in {

  nix = {
    settings = {
      substituters = [
        "ssh-ng://nix-ssh@vera"
        "ssh-ng://nix-ssh@vera-deck"
      ];

      trusted-public-keys = with nix-pub-keys; [
        miracle-crusher
        vera-deck
      ];
    };

    extraOptions = ''
      secret-key-files = ${config.sops.secrets.nix-private-key.path}
      fallback = true
    '';
  };

}