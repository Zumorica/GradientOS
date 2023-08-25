{
  core = ./core;

  aarch64-emulation = ./modules/aarch64-emulation.nix;
  gnupg = ./modules/gnupg.nix;
  neith-locale = ./modules/neith-locale.nix;
  networkd = ./modules/networkd.nix;
  nix-store-serve = ./modules/nix-store-serve.nix;
  plymouth = ./modules/plymouth.nix;
  podman = ./modules/podman.nix;
  steamcmd = ./modules/steamcmd.nix;
  system76-scheduler = ./modules/system76-scheduler.nix;
  uwu-style = ./modules/uwu-style.nix;
  v4l2loopback = ./modules/v4l2loopback.nix;
  vera-locale = ./modules/vera-locale.nix;
  virtualisation = ./modules/virtualisation.nix;
  wine = ./modules/wine.nix;

  graphical = ./modules/graphical/default.nix;
  graphical-gamescope = ./modules/graphical/gamescope.nix;
  graphical-kde = ./modules/graphical/kde.nix;
  graphical-steam = ./modules/graphical/steam.nix;
  graphical-sunshine = ./modules/graphical/sunshine.nix;

  home-zsh = ./modules/home/zsh.nix;

  pipewire = ./modules/pipewire/default.nix;
  pipewire-um2 = ./modules/pipewire/um2/default.nix;
  pipewire-virtual-sink = ./modules/pipewire/virtual-sink/default.nix;
  pipewire-low-latency = ./modules/pipewire/low-latency.nix;

  hardware-amdcpu = ./hardware/amdcpu.nix;
  hardware-amdgpu = ./hardware/amdgpu.nix;
  hardware-azure = ./hardware/azure.nix;
  hardware-bluetooth = ./hardware/bluetooth.nix;
  hardware-home-dcp-l2530dw = ./hardware/home-dcp-l2530dw.nix;
  hardware-intelgpu-vaapi = ./hardware/intelgpu-vaapi.nix;
  hardware-openrazer = ./hardware/openrazer.nix;
  hardware-raspberrypi4 = ./hardware/raspberrypi4.nix;
  hardware-steamdeck = ./hardware/steamdeck.nix;
  hardware-wacom = ./hardware/wacom.nix;
  hardware-webcam = ./hardware/webcam.nix;
  hardware-xbox-one-controller = ./hardware/xbox-one-controller.nix;
}