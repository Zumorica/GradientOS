{ config, pkgs, lib, ... }:
let
  addresses = config.gradient.const.wireguard.addresses;
  settings = pkgs.writeText "mediamtx.yml" (builtins.toJSON {

    api = true;
    apiAddress = ":9997";

    authMethod = "internal";
    authInternalUsers = [
      {
        user = "any";
        pass = "";
        ips = [];
        permissions = [
          { action = "publish"; path = ""; }
          { action = "read"; path = ""; }
          { action = "playback"; path = ""; }
        ];
      }
      {
        user = "any";
        pass = "";
        ips = with addresses.gradientnet; [
          "127.0.0.1"
          "::1"
          miracle-crusher
        ];
        permissions = [
          { action = "api"; }
          { action = "metrics"; }
          { action = "pprof"; }
        ];
      }
    ];

    paths = {
      constellation = {
        source = "publisher";
      };
      all_others = {};
    };

  });
in
{

  virtualisation.oci-containers.containers.mediamtx = {
    image = "bluenviron/mediamtx:1.6.0";
    volumes = [ "${settings}:/mediamtx.yml" ];
    environment = { TZ = config.time.timeZone; };
    extraOptions = [ "--network=host" ];
  };

  # TODO: Remove below.
  networking.firewall.trustedInterfaces = [ "gradientnet" ];

}