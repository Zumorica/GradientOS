{ ... }:
let
  ssh-pub-keys = import ../misc/ssh-pub-keys.nix;
in {

  nix.sshServe = {
    enable = true;
    write = true;
    protocol = "ssh-ng";
    keys = with ssh-pub-keys; [
      vera
      neith
      miracle-crusher
      vera-deck
      neith-deck
    ];
  };

  nix.settings.trusted-users = [ "nix-ssh" ];

}