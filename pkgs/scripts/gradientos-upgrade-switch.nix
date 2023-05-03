{ writeShellApplication, nixos-rebuild, ... }:

writeShellApplication {
  name = "gradientos-upgrade-switch";

  runtimeInputs = [ nixos-rebuild ];

  text = ''
    sudo nixos-rebuild switch --flake "git+https://github.com/Zumorica/GradientOS" --show-trace --refresh -L "$@"
  '';
}