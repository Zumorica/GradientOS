{
  description = "GradientOS flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable-2211.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-stable-2305.url = "github:NixOS/nixpkgs/nixos-23.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixlib.url = "github:nix-community/nixpkgs.lib";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    gradient-generator = {
      url = "git+ssh://git@github.com/Zumorica/gradient-generator";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gradient-moe = {
      url = "git+ssh://git@github.com/Zumorica/gradient.moe";
      flake = false;
    };

    jovian-nixos = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      flake = false;
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable-2211";
    };

    nix-gaming = {
      url = "github:/fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, gradient-generator, jovian-nixos, sops-nix, nixos-hardware, ... }:
  let
    jovian-modules = (jovian-nixos + "/modules");
    jovian-pkgs = import (jovian-nixos + "/overlay.nix");
    jovian-workaround = import ./pkgs/jovian-workaround.nix;
  in
  rec {
    lib = ( import ./lib self );

    nixosConfigurations = {

      miracle-crusher = lib.gradientosSystem 
      {
        name = "miracle-crusher";

        modules = [
          sops-nix.nixosModules.sops
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          gradient-generator.nixosModules.x86_64-linux.default
          ./modules/wine.nix
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/vera-locale.nix
          ./modules/virtualisation.nix
          ./modules/nix-store-serve.nix
          ./modules/graphical
          ./modules/graphical/kde.nix
          ./modules/graphical/steam.nix
          ./hardware/um2
          ./hardware/wacom.nix
          ./hardware/sound.nix
          ./hardware/sound-low-latency.nix
          ./hardware/amdcpu.nix
          ./hardware/amdgpu.nix
          ./hardware/webcam.nix
          ./hardware/bluetooth.nix
          ./hardware/openrazer.nix
          ./hardware/home-dcp-l2530dw.nix
          ./hardware/xbox-one-controller.nix
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
          ./users/vera/graphical
        ];
      };

      neith-deck = lib.gradientosSystem 
      {
        name = "neith-deck";
        overlays = [ jovian-pkgs jovian-workaround ];

        modules = [
          sops-nix.nixosModules.sops
          jovian-modules
          ./modules/wine.nix
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/neith-locale.nix
          ./modules/nix-store-serve.nix
          ./modules/graphical
          ./modules/graphical/kde.nix
          ./modules/graphical/steam.nix
          ./hardware/sound.nix
          ./hardware/sound-low-latency.nix
          ./hardware/amdcpu.nix
          ./hardware/amdgpu.nix
          ./hardware/webcam.nix
          ./hardware/bluetooth.nix
          ./hardware/steamdeck.nix
        ];

        users.neith.modules = [
          sops-nix.homeManagerModule
          ./users/neith/graphical
        ];
      };

      vera-deck = lib.gradientosSystem 
      {
        name = "vera-deck";
        overlays = [ jovian-pkgs jovian-workaround ];

        modules = [
          sops-nix.nixosModules.sops
          jovian-modules
          ./modules/wine.nix
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/vera-locale.nix
          ./modules/virtualisation.nix
          ./modules/nix-store-serve.nix
          ./modules/graphical
          ./modules/graphical/kde.nix
          ./modules/graphical/steam.nix
          ./hardware/sound.nix
          ./hardware/sound-low-latency.nix
          ./hardware/amdcpu.nix
          ./hardware/amdgpu.nix
          ./hardware/webcam.nix
          ./hardware/bluetooth.nix
          ./hardware/steamdeck.nix
          ./hardware/openrazer.nix
          ./hardware/home-dcp-l2530dw.nix
          ./hardware/xbox-one-controller.nix
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
          ./users/vera/graphical
        ];
      };

      briah = lib.gradientosSystem
      {
        name = "briah";
        system = "aarch64-linux";
        
        modules = [
          sops-nix.nixosModules.sops
          ./modules/nix-store-serve.nix
          ./hardware/raspberrypi.nix
          ./hardware/home-dcp-l2530dw.nix
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
        ];
      };
    };
  };
}
