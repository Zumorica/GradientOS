{ config, ... }:
let
  secrets = config.sops.secrets;
in {

  gradient-generator.services.daily-avatar = {
    enable = true;
    firefoxProfile = "/home/vera/.mozilla/firefox/be78j9ok.default-release";
    gmicUpdateFile = "/home/vera/.config/gmic/update322.gmic";
    user = "vera";
  };

  systemd.services."gradient-generator.daily-avatar".serviceConfig.EnvironmentFile = secrets.gradient-generator-environment.path;

}