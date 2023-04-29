{ pkgs, ... }:

{

  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };

  hardware.sane = {
    enable = true;
    openFirewall = true;
    extraBackends = [ pkgs.sane-airscan ];
    brscan5 = {
      enable = true;
      netDevices.brother = {
        model = "DCP-L2530DW";
        nodename = "BRW4CD5776D8616";
      };
    };
  };

}