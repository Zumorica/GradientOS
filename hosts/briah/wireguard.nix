{ config, pkgs, ... }:
{
  networking.wireguard.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.wireguard.interfaces = {

  };

  networking.firewall.trustedInterfaces = [ ];
  systemd.network.wait-online.ignoredInterfaces = [ ];

  networking.hosts = {

  };
}