{ ... }:
let
  ports = import ./misc/service-ports.nix;
in {

  services.klipper = {
    enable = true;
    configFile = ./klipper.cfg;
    octoprintIntegration = true;
  };

  services.octoprint = {
    enable = true;
    port = ports.octoprint;
    plugins = plugins: with plugins; [
      marlingcodedocumentation
      simpleemergencystop
      printtimegenius
      costestimation
      octoklipper
      gcodeeditor
      stlviewer
      telegram
      themeify
    ];
  };

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = with ports; [ octoprint ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = with ports; [ octoprint ];

}