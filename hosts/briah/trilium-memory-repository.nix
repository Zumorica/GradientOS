{ config, pkgs, ... }:
{

  containers.memory-repository = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.128.1";
    localAddress = "192.168.128.2";

    config = { config, pkgs, ... }:
    {
      services.trilium-server = {
        enable = true;
        instanceName = "Memory Repository";
        dataDir = "TODO";
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 80 ];
      };
    };

    extraFlags = [
      # Workaround https://github.com/NixOS/nixpkgs/issues/196370
      "--resolv-conf=bind-host"
    ];
  };

}