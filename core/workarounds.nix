{ lib, ... }:
{

  # -- AS OF 2024-06-09 --
  # Required to work around https://github.com/NixOS/nixpkgs/issues/315574
  # Remove when https://github.com/NixOS/nixpkgs/pull/318511 is merged or version is increased
  options.system.nixos.codeName = lib.mkOption { readOnly = false; };
  config.system.nixos.codeName = "Vicuna";

}