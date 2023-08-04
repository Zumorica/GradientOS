{ ... }:

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
      
    };
  };

}