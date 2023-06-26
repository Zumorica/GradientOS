{ ... }:
let
  ports = import misc/service-ports.nix;
in {

  config.virtualisation.oci-containers.containers.memory-repository = {
    image = "zadam/trilium:0.60-latest";
    ports = [ "127.0.0.1:${ports.trilium}:8080" ];
    volumes = [ "/data/trilium:/home/node/trilium-data" ];
  };

}