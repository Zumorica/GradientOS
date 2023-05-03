{ writeShellApplication, nixos-rebuild, ... }:

writeShellApplication {
  name = "gradientos-upgrade-test";

  runtimeInputs = [ nixos-rebuild ];

  text = ''
    sudo nixos-rebuild test --flake "https://github.com/Zumorica/GradientOS" --show-trace --refresh -L "$@"
  '';
}