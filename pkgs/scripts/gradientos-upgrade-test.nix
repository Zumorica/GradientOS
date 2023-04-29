{ writeShellApplication, nixos-rebuild, ... }:

writeShellApplication {
  name = "gradientos-upgrade-test";

  runtimeInputs = [ nixos-rebuild ];

  text = ''
    sudo nixos-rebuild test --flake "git+ssh://git@github.com/Zumorica/GradientOS" --show-trace --refresh -L "$@"
  '';
}