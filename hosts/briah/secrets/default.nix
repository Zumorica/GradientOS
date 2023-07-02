{ config, ... }:

{

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yml;

    secrets = {
      
      wireguard-private-key = { restartUnits = [ "wireguard-*" ]; };
      duckdns = {
        restartUnits = [ "duckdns" ];
        mode = "0500";
        owner = config.users.users.duckdns.name;
        group = config.users.users.duckdns.group;
      };

    };
  };

}