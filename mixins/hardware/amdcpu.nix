{ self, config, lib, pkgs, ... }:

{

  imports = [
    self.inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
  ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    ryzenadj
    zenstates
  ];

}