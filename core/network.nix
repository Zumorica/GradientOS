{ lib, pkgs, ... }:

{
  networking.wireless.enable = lib.mkForce false;

  # Enable NetworkManager with dnsmasq
  networking.networkmanager = {
    enable = true;
    dns = "dnsmasq";
  };

  environment.etc."NetworkManager/dnsmasq.d/nameservers.conf".text = ''
server=1.1.1.1
server=1.0.0.1
server=8.8.8.8
server=8.8.4.4
  '';

  # Ignore loopback/virtual interfaces.
  systemd.network.wait-online.ignoredInterfaces = ["lo" "virbr0"];
}