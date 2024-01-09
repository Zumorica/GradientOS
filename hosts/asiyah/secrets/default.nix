{ config, ... }:

{

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yml;

    secrets = {

      gradient-generator-environment = { restartUnits = [ "gradient-generator.daily-avatar.service" ]; };

      wireguard-private-key = { restartUnits = [ "wireguard-*" ]; };
      
      deluge-auth = {
        mode = "0440";
        group = config.services.deluge.group;
        restartUnits = [ "deluge.service" ];
      };

      oauth2-proxy-secrets = { restartUnits = [ "oauth2_proxy.service" ]; };

    };
  };

}