{ config, ... }:
let
  nix-pub-keys = import ../../misc/nix-pub-keys.nix;
in {

  nix = {
    settings = {
      substituters = [
        "ssh-ng://nix-ssh@deck"
        "ssh-ng://nix-ssh@neith"
      ];

      trusted-public-keys = with nix-pub-keys; [
        vera-deck
        neith-deck
      ];
    };

    extraOptions = ''
      secret-key-files = ${config.sops.secrets.nix-private-key.path}
      connect-timeout = 10
      fallback = true
    '';
  };

}