{ ... }:
{

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "TODO";
  };

  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];

}