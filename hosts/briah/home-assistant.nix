{ config, pkgs, ... }:
let
  ports = import ./misc/service-ports.nix;
  addresses = config.gradient.const.wireguard.addresses.gradientnet;
in
{

  services.home-assistant = {
    enable = true;
    lovelaceConfigWritable = true;
    extraComponents = [
      "homeassistant_alerts"
      "pvpc_hourly_pricing"
      "assist_pipeline"
      "default_config"
      "history_stats"
      "shopping_list"
      "utility_meter"
      "telegram_bot"
      "geo_location"
      "conversation"
      "image_upload"
      "media_source"
      "air_quality"
      "mobile_app"
      "xiaomi_ble"
      "bluetooth"
      "telegram"
      "recorder"
      "zeroconf"
      "logbook"
      "history"
      "esphome"
      "brother"
      "webhook"
      "backup"
      "energy"
      "camera"
      "stream"
      "config"
      "cloud"
      "moon"
      "dhcp"
      "ssdp"
      "tuya"
      "met"
      "zha"
      "sun"
      "usb"
      "ios"
      "map"
      "sql"
      "my"
    ];
    customComponents = with pkgs.home-assistant-custom-components; [
      midea-air-appliances-lan
      moonraker
      smartir
    ];
    config.telegram_bot = "!include telegram.yaml";
    config.automation = "!include automations.yaml";
    config.notify = "!include notifiers.yaml";
    config.script = "!include scripts.yaml";
    config.http = {
      server_port = ports.home-assistant;
      use_x_forwarded_for = true;
      trusted_proxies = [ "${addresses.asiyah}" "127.0.0.1" ];
      ip_ban_enabled = true;
      login_attempts_threshold = 10;
    };

    config.lovelace.mode = "storage";
    config.default_config = {};
    config.mobile_app = {};
    config.history = {};
    config.recorder = {
      purge_keep_days = 365;
    };
  };

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.home-assistant ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.home-assistant ];

}