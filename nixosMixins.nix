{
  core = ./core/default.nix;

  aarch64-emulation = ./mixins/aarch64-emulation.nix;
  declarative-flatpak = ./mixins/declarative-flatpak.nix;
  gnupg = ./mixins/gnupg.nix;
  monado = ./mixins/monado.nix;
  neith-locale = ./mixins/neith-locale.nix;
  networkd = ./mixins/networkd.nix;
  nix-store-serve = ./mixins/nix-store-serve.nix;
  plymouth = ./mixins/plymouth.nix;
  podman = ./mixins/podman.nix;
  steamcmd = ./mixins/steamcmd.nix;
  system76-scheduler = ./mixins/system76-scheduler.nix;
  upgrade-diff = ./mixins/upgrade-diff.nix;
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
  graphical-wayland-autologin-workaround = ./mixins/graphical/wayland/autologin-workaround.nix;
  graphical-wayland-environment-variables = ./mixins/graphical/wayland/environment-variables.nix;

  home-zsh = ./mixins/home/zsh.nix;

  pipewire = ./mixins/pipewire/default.nix;
  pipewire-um2 = ./mixins/pipewire/um2/default.nix;
  pipewire-virtual-sink = ./mixins/pipewire/virtual-sink/default.nix;
  pipewire-input-normalizer = ./mixins/pipewire/input-normalizer.nix;
  pipewire-low-latency = ./mixins/pipewire/low-latency.nix;
  pipewire-rnnoise = ./mixins/pipewire/rnnoise.nix;

  hardware-amdcpu = ./mixins/hardware/amdcpu.nix;
  hardware-amdgpu = ./mixins/hardware/amdgpu.nix;
  hardware-azure = ./mixins/hardware/azure.nix;
  hardware-bluetooth = ./mixins/hardware/bluetooth.nix;
  hardware-home-dcp-l2530dw = ./mixins/hardware/home-dcp-l2530dw.nix;
  hardware-intelgpu-vaapi = ./mixins/hardware/intelgpu-vaapi.nix;
  hardware-logitech-driving-wheels = ./mixins/hardware/logitech-driving-wheels.nix;
  hardware-openrazer = ./mixins/hardware/openrazer.nix;
  hardware-qmk = ./mixins/hardware/qmk.nix;
  hardware-raspberrypi4 = ./mixins/hardware/raspberrypi4.nix;
  hardware-steamdeck = ./mixins/hardware/steamdeck.nix;
  hardware-wacom = ./mixins/hardware/wacom.nix;
  hardware-webcam = ./mixins/hardware/webcam.nix;
  hardware-xbox-one-controller = ./mixins/hardware/xbox-one-controller.nix;
}