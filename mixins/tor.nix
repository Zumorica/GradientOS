{ pkgs, ... }:
{

  services.tor = {
    enable = true;
    client.enable = true;
    client.dns.enable = true;
    torsocks.enable = true;
  };

  environment.systemPackages = with pkgs; [
    tor-browser
  ];

}