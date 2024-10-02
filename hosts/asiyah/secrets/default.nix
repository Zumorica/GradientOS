{ config, ... }:

{

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yml;

    secrets = {

      gradient-generator-environment = { restartUnits = [ "gradient-generator.daily-avatar.service" ]; };

      wireguard-private-key = { restartUnits = [ "wireguard-*" ]; };

      nix-private-key = { };
      
      deluge-auth = {
        mode = "0440";
        group = config.services.deluge.group;
        restartUnits = [ "deluge.service" ];
      };

      oauth2-proxy-secrets = { restartUnits = [ "oauth2_proxy.service" ]; };

      duckdns = {
        mode = "0500";
        owner = config.users.users.duckdns.name;
        group = config.users.users.duckdns.group;
        restartUnits = [ "duckdns" ];
      };

      syncthing-cert = {
        format = "binary";
        sopsFile = ./syncthing-cert.pem;
        restartUnits = [ "syncthing.service" ];
      };

      syncthing-key = {
        format = "binary";
        sopsFile = ./syncthing-key.pem;
        restartUnits = [ "syncthing.service" ];
      };

    };
  };

}