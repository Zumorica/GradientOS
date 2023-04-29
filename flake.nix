{
  description = "GradientOS flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable-2211.url = "github:NixOS/nixpkgs/nixos-22.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixlib.url = "github:nix-community/nixpkgs.lib";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    gradient-generator = {
      url = "git+ssh://git@github.com/Zumorica/gradient-generator";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    jovian-nixos = {
      url = "github:Zumorica/Jovian-NixOS/unstable";
      flake = false;
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #nixos-generators = {
    #  url = "github:nix-community/nixos-generators";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { self, nixpkgs, nixpkgs-stable-2211, nixlib, flake-utils, home-manager, gradient-generator, jovian-nixos, sops-nix, disko, nixos-hardware, ... }:
  let
    jovian-modules = (jovian-nixos + "/modules");
    jovian-pkgs = import (jovian-nixos + "/overlay.nix");
    jovian-workaround = import ./pkgs/ignoreMissingKernelModules.nix;
    gradient-pkgs = import ./pkgs self;
    override-pkgs = { system, overlays ? [] }: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = overlays;
    };
  in
  rec {
    nixosConfigurations = rec {

      miracle-crusher = nixpkgs.lib.nixosSystem 
      rec {
        system = "x86_64-linux";
        pkgs = override-pkgs { inherit system; overlays = [ gradient-pkgs ]; };
        specialArgs = { inherit self; };
        modules = [
          sops-nix.nixosModules.sops
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          gradient-generator.nixosModules.${system}.default
          ./core
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/wine.nix
          ./modules/virtualisation.nix
          ./modules/graphical
          ./modules/graphical/kde.nix
          ./modules/graphical/steam.nix
          ./hardware/um2
          ./hardware/sound.nix
          ./hardware/amdcpu.nix
          ./hardware/amdgpu.nix
          ./hardware/webcam.nix
          ./hardware/bluetooth.nix
          ./hardware/home-dcp-l2530dw.nix
          ./hardware/xbox-one-controller.nix
          ./users/vera
          ./hosts/miracle-crusher
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vera = {
              imports = [
                sops-nix.homeManagerModule
                ./users/common/home.nix
                ./users/vera/home.nix
                ./users/vera/graphical
              ];
            };
          }
        ];
      };

      neith-deck = nixpkgs.lib.nixosSystem 
      rec {
        system = "x86_64-linux";
        pkgs = override-pkgs { inherit system; overlays = [ gradient-pkgs jovian-pkgs jovian-workaround ]; };
        specialArgs = { inherit self; };
        modules = [
          jovian-modules
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma5.nix"
          ./core
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/wine.nix
          ./modules/graphical
          ./modules/graphical/kde.nix
          ./modules/graphical/steam.nix
          ./hardware/sound.nix
          ./hardware/amdcpu.nix
          ./hardware/amdgpu.nix
          ./hardware/webcam.nix
          ./hardware/bluetooth.nix
          ./hardware/steamdeck.nix
          ./users/neith
          ./hosts/neith-deck
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.neith = {
              imports = [
                sops-nix.homeManagerModule
                ./users/common/home.nix
                ./users/neith/home.nix
                ./users/neith/graphical
              ];
            };
          }
          sops-nix.nixosModules.sops
          #disko.nixosModules.disko
        ];
      };

      vera-deck = nixpkgs.lib.nixosSystem 
      rec {
        system = "x86_64-linux";
        pkgs = override-pkgs { inherit system; overlays = [ gradient-pkgs jovian-pkgs jovian-workaround ]; };
        specialArgs = { inherit self; };
        modules = [
          #"${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma5.nix"
          sops-nix.nixosModules.sops
          jovian-modules
          ./core
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/wine.nix
          ./modules/virtualisation.nix
          ./modules/graphical
          ./modules/graphical/kde.nix
          ./modules/graphical/steam.nix
          ./hardware/sound.nix
          ./hardware/amdcpu.nix
          ./hardware/amdgpu.nix
          ./hardware/webcam.nix
          ./hardware/bluetooth.nix
          ./hardware/steamdeck.nix
          ./users/vera
          ./hosts/vera-deck
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vera = {
              imports = [
                sops-nix.homeManagerModule
                ./users/common/home.nix
                ./users/vera/home.nix
                ./users/vera/graphical
              ];
            };
          }
        ];
      };
    };
  };
}
