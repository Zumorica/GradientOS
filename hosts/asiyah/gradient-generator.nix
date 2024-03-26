{ config, self, ... }:
let
  secrets = config.sops.secrets;
in {

  gradient-generator.services.daily-avatar = {
    enable = true;
    enableDiscordUpload = false;
    enableMastodonUpload = false;
    enableMastodonBotUpload = true;
    mastodonBotUrl = "https://botsin.space";
    user = "vera";
  };

  environment.systemPackages = [
    self.inputs.gradient-generator.packages.x86_64-linux.default
  ];

  systemd.services."gradient-generator.daily-avatar".serviceConfig.EnvironmentFile = secrets.gradient-generator-environment.path;

}