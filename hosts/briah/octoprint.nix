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
    ];
  };

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.octoprint ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.octoprint ];

}