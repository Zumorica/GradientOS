{ ... }:

{

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Class = "0x000100";
        ControllerMode = "dual";
        FastConnectable = true;
        JustWorksRepairing = "always";
        Privacy = "device";
      };
      Policy = {
        ReconnectIntervals = "1,1,2,3,5,8,13,21,34,55";
        AutoEnable = true;
      };
    };
  };

}