{ config, ... }:

{

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yml;

    secrets = {
      
      wireguard-private-key = { restartUnits = [ "wireguard-*" ]; };

      #pong-api-token = {
      #  mode = "0440";
      #  owner = config.users.users.ss14-watchdog.name;
      #  group = config.users.users.ss14-watchdog.group;
      #  restartUnits = [ "space-station-14-watchdog" ];
      #};

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