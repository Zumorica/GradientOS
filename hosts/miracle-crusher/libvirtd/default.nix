{ pkgs, ... }:
let
  hookDependencies = with pkgs; [ libvirt kmod gawk lsof ];
  win10-prepare-begin-hook = pkgs.writeShellApplication {
    name = "win10-prepare-begin-hook";
    runtimeInputs = hookDependencies;
    text = builtins.readFile ./win10-prepare-begin-hook.sh;
    checkPhase = "";
  };
  win10-release-end-hook = pkgs.writeShellApplication {
    name = "win10-release-end-hook";
    runtimeInputs = hookDependencies;
    text = builtins.readFile ./win10-release-end-hook.sh;
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
      "win10-prepare-begin.sh" = "${win10-prepare-begin-hook}/bin/win10-prepare-begin-hook";
      "win10-release-end.sh" = "${win10-release-end-hook}/bin/win10-release-end-hook";
    };
  };
}