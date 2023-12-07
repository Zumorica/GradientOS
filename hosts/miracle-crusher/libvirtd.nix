{ ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      runAsRoot = true;
      ovmf.enable = true;
    };
    hooks.qemu = {
      
    };
  };
}