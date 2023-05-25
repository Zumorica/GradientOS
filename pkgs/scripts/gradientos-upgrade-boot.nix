{ writeShellApplication, nixos-rebuild, ... }:

writeShellApplication {
  name = "gradientos-upgrade-boot";

  runtimeInputs = [ nixos-rebuild ];

  text = ''
    sudo nixos-rebuild boot --flake "git+https://github.com/Zumorica/GradientOS" --show-trace --refresh -L "$@"
  '';
}