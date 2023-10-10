{ ... }:
let
  ports = import ./misc/service-ports.nix;
in {
  services.octoprint = {
    enable = true;
    port = ports.octoprint;
    plugins = plugins: with plugins; [
      marlingcodedocumentation
      displaylayerprogress
      simpleemergencystop
      bedlevelvisualizer
      printtimegenius
      costestimation
      octoklipper
      gcodeeditor
      dashboard
      stlviewer
      telegram
      themeify
      touchui
    ];
    extraConfig = {
      accessControl = {
        autologinLocal = true;
        autologinAs = "vera";
        localNetworks = [ "127.0.0.0/8" ];
      };
    };
  };

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.octoprint ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.octoprint ];

}