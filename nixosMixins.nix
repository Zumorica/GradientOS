{
  core = ./core/default.nix;

  aarch64-emulation = ./mixins/aarch64-emulation.nix;
  gnupg = ./mixins/gnupg.nix;
  neith-locale = ./mixins/neith-locale.nix;
  networkd = ./mixins/networkd.nix;
  nix-store-serve = ./mixins/nix-store-serve.nix;
  plymouth = ./mixins/plymouth.nix;
  podman = ./mixins/podman.nix;
  steamcmd = ./mixins/steamcmd.nix;
  system76-scheduler = ./mixins/system76-scheduler.nix;
  uwu-style = ./mixins/uwu-style.nix;
  v4l2loopback = ./mixins/v4l2loopback.nix;
  vera-locale = ./mixins/vera-locale.nix;
  virtualisation = ./mixins/virtualisation.nix;
  wine = ./mixins/wine.nix;

  graphical = ./mixins/graphical/default.nix;
  graphical-gamescope = ./mixins/graphical/gamescope.nix;
  graphical-kde = ./mixins/graphical/kde.nix;
  graphical-steam = ./mixins/graphical/steam.nix;
  graphical-sunshine = ./mixins/graphical/sunshine.nix;

  home-zsh = ./mixins/home/zsh.nix;

  pipewire = ./mixins/pipewire/default.nix;
  pipewire-um2 = ./mixins/pipewire/um2/default.nix;
  pipewire-virtual-sink = ./mixins/pipewire/virtual-sink/default.nix;
  pipewire-low-latency = ./mixins/pipewire/low-latency.nix;

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