{ config, ... }:
let
  nix-pub-keys = import ../../misc/nix-pub-keys.nix;
in {

  nix = {
    settings = {
      substituters = [
        # Disabled until https://github.com/NixOS/nix/pull/7188 is merged.
        # "ssh-ng://nix-ssh@deck?priority=50"
        # "ssh-ng://nix-ssh@neith?priority=100"
      ];

      trusted-public-keys = with nix-pub-keys; [
        vera-deck
        neith-deck
      ];
    };

    extraOptions = ''
      secret-key-files = ${config.sops.secrets.nix-private-key.path}
    '';
  };

}