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

    jovian-nixos = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      flake = false;
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/wine.nix
          ./modules/virtualisation.nix
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
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/wine.nix
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
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/wine.nix
          ./modules/virtualisation.nix
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
          ./hardware/home-dcp-l2530dw.nix
          ./hardware/xbox-one-controller.nix
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
          ./users/vera/graphical
        ];
      };

/*    atziluth = nixpkgs.lib.nixosSystem 
      rec {
        system = "x86_64-linux";
        pkgs = override-pkgs { inherit system; overlays = [ gradient-pkgs ]; };
        specialArgs = { inherit self; };
        modules = [
          sops-nix.nixosModules.sops
          ./core
          ./modules/virtualisation.nix
          ./hardware/home-dcp-l2530dw.nix
          ./users/vera
          ./hosts/atziluth
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vera = {
              imports = [
                sops-nix.homeManagerModule
                ./users/common/home.nix
                ./users/vera/home.nix
              ];
            };
          }
        ];
      };

      briah = nixpkgs.lib.nixosSystem
      rec {
        system = "aarch64-linux";
        pkgs = override-pkgs { inherit system; overlays = [ gradient-pkgs ]; };
        specialArgs = { inherit self; };
        modules = [
          sops-nix.nixosModules.sops
          ./core
          ./hardware/raspberrypi.nix
          ./users/vera
          ./hosts/briah
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vera = {
              imports = [
                sops-nix.homeManagerModule
                ./users/common/home.nix
                ./users/vera/home.nix
              ];
            };
          }
        ];
      }; */
    };
  };
}
