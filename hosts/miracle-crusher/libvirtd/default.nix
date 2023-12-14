{ pkgs, ... }:
let
  win10-hooks = pkgs.writeShellApplication {
    name = "win10-hooks";
    runtimeInputs = with pkgs; [ libvirt kmod gawk lsof ];
    text = builtins.readFile ./win10-hooks.sh;
    checkPhase = "";
  };
in {
  
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      runAsRoot = true;
      ovmf.enable = true;
    };
    hooks.qemu = {
      "win10-hooks.sh" = "${win10-hooks}/bin/win10-hooks";
    };
  };

  boot.extraModprobeConfig = ''
    options vfio-pci ids=1002:73bf,1002:ab28,1002:73a6,1002:73a4
  '';
}