{ ... }:
{

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    # externalInterface = "TODO";
  };

}