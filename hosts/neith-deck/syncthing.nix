{ config, ... }:
let
  secrets = config.sops.secrets;
in {
  services.syncthing = {
    enable = true;
    user = "neith";
    dataDir = "/home/neith";
    configDir = "/home/neith/.config/syncthing";
    cert = secrets.syncthing-cert.path;
    key = secrets.syncthing-key.path;
    overrideFolders = false;
    overrideDevices = false;
    devices = {
      SPACE-CATGIRL = {
        addresses = [
          "tcp://192.168.24.1:22000"
          "tcp://game.zumorica.es:22000"
        ];
        id = "YGAS3YA-IXVU3R5-KQR6A2Z-Z5GQCSX-XXLRS4D-4WPJQHA-CKODYMV-KZSYUQO";
        introducer = true;
      };

      MiracleCrusher = {
        addresses = [
          "tcp://192.168.24.2:22000"
        ];
        id = "SXWKC5N-MKDTRAN-ZBA4SJQ-EACWWAJ-W75C5AE-EQ354MY-CNJRQMQ-OZ67TQY";
        introducer = true;
      };

    };

    folders = {
      "/home/neith/Documents/TheMidnightHall" = {
        id = "ykset-ue2ke";
        label = "The Midnight Hall";
        devices = [ "SPACE-CATGIRL" "MiracleCrusher" ];
      };
    };
  };
}