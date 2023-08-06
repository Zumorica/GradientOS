{ config, ... }:

{

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yml;

    secrets = {

      wireguard-private-key = { restartUnits = [ "wireguard-*" ]; };

      stream-htpasswd = {
        mode = "0444";
        restartUnits = [ "nginx.service" ];
      };
      
      deluge-auth = {
        mode = "0440";
        group = config.services.deluge.group;
        restartUnits = [ "deluge.service" ];
      };

    };
  };

}