{ self, lib, ... }:
{

  imports = [ (import "${self.inputs.mobile-nixos}/lib/configuration.nix" { device = "uefi-x86_64"; }) ];
  
  mobile = {
    enable = lib.mkForce false;
    boot.stage-1.enable = true;
    boot.stage-1.kernel.useNixOSKernel = lib.mkForce true;
    boot.stage-1.gui.waitForDevices.enable = lib.mkForce true;
    beautification = {
      silentBoot = true;
      splash = true;
    };
  };

}