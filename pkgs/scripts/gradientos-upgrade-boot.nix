{ writeShellApplication, nixos-rebuild, ... }:

writeShellApplication {
  name = "gradientos-upgrade-switch";

  runtimeInputs = [ nixos-rebuild ];

  text = ''
    sudo nixos-rebuild boot --flake "https://github.com/Zumorica/GradientOS" --show-trace --refresh -L "$@"
  '';
}