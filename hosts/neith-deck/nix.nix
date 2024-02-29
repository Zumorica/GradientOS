{ config, ... }:
let
  nix-pub-keys = import ../../misc/nix-pub-keys.nix;
in {

  nix = {
    settings = {
      substituters = [
        # Disabled until https://github.com/NixOS/nix/pull/7188 is merged.
        # "ssh-ng://nix-ssh@vera?priority=50"
        # "ssh-ng://nix-ssh@vera-deck?priority=100"
      ];

      trusted-public-keys = with nix-pub-keys; [
        miracle-crusher
        vera-deck
      ];
    };

    extraOptions = ''
      secret-key-files = ${config.sops.secrets.nix-private-key.path}
    '';
  };

}