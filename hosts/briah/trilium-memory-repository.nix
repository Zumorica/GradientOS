{ ... }:
let
  ports = import misc/service-ports.nix;
in {

  virtualisation.oci-containers.containers.memory-repository = {
    image = "zadam/trilium:0.60-latest";
    ports = [ "127.0.0.1:${toString ports.trilium}:8080" ];
    volumes = [ "/data/trilium:/home/node/trilium-data" ];
  };

  networking.firewall.allowedTCPPorts = [ ports.trilium ];

}