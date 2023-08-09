{ config, ... }:
let
  secrets = config.sops.secrets;
in {

  gradient-generator.services.daily-avatar = {
    enable = true;
    enableDiscordUpload = false;
    enableMastodonUpload = false;
    enableMastodonBotUpload = true;
    gmicUpdateFile = "/home/vera/.config/gmic/update326.gmic";
    mastodonBotUrl = "https://botsin.space";
    user = "vera";
  };

  systemd.services."gradient-generator.daily-avatar".serviceConfig.EnvironmentFile = secrets.gradient-generator-environment.path;

}