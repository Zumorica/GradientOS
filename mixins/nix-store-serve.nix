{ config, ... }:
{

  nix.sshServe = {
    enable = true;
    write = true;
    protocol = "ssh-ng";
    keys = with config.gradient.const.ssh.pubKeys; [
      vera
      neith
      bernkastel
      vera-deck
      vera-deck-oled
      neith-deck
      asiyah
      briah
    ];
  };

  nix.settings.trusted-users = [ "nix-ssh" ];
  nix.extraOptions = ''
    secret-key-files = ${config.sops.secrets.nix-private-key.path}
  '';

}