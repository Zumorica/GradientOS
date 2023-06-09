{
  description = "GradientOS flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable-2211.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-stable-2305.url = "github:NixOS/nixpkgs/nixos-23.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixlib.follows = "nixlib";
    };

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

    ss14-watchdog = {
      url = "github:space-wizards/SS14.Watchdog";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, gradient-generator, jovian-nixos, sops-nix, nixos-hardware, ss14-watchdog, ... }:
  let
    ips = import ./misc/wireguard-addresses.nix;
    colmena-tags = import ./misc/colmena-tags.nix;
    mkFlake = (import ./lib/mkFlake.nix self);
    jovian-modules = (jovian-nixos + "/modules");
    jovian-pkgs = import (jovian-nixos + "/overlay.nix");
    kernel-workaround = import ./pkgs/kernel-workaround.nix;
  in
  mkFlake {

    gradientosConfigurations = [
        
      {
        name = "miracle-crusher";

        modules = [
          sops-nix.nixosModules.sops
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          gradient-generator.nixosModules.x86_64-linux.default
          ./modules/wine.nix
          ./modules/podman.nix
          ./modules/plymouth.nix
          ./modules/uwu-style.nix
          ./modules/vera-locale.nix
          ./modules/virtualisation.nix
          ./modules/nix-store-serve.nix
          ./modules/aarch64-emulation.nix
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

        generators = [ "install-iso" ];

        deployment = {
          targetHost = ips.gradientnet.miracle-crusher;
          tags = with colmena-tags; [ x86_64 desktop vera ];
          allowLocalDeployment = true;
          buildOnTarget = true;
        };
      }

      {
        name = "neith-deck";
        overlays = [ jovian-pkgs kernel-workaround ];

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

        generators = [ "install-iso" ];

        deployment = {
          targetHost = ips.lilynet.neith-deck;
          tags = with colmena-tags; [ x86_64 steam-deck desktop neith ];
          allowLocalDeployment = true;
        };
      }

      {
        name = "vera-deck";
        overlays = [ jovian-pkgs kernel-workaround ];

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

        generators = [ "install-iso" ];

        deployment = {
          targetHost = ips.gradientnet.vera-deck;
          tags = with colmena-tags; [ x86_64 steam-deck desktop vera ];
          allowLocalDeployment = true;
        };
      }

      {
        name = "asiyah";

        modules = [
          sops-nix.nixosModules.sops
          ./hardware/azure.nix
          ./modules/vera-locale.nix
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
        ];

        generators = [ "azure" ];
      }

       {
        name = "briah";
        system = "aarch64-linux";
        overlays = [ kernel-workaround ];
        
        modules = [
          ss14-watchdog.nixosModules.default
          sops-nix.nixosModules.sops
          ./modules/vera-locale.nix
          ./hardware/raspberrypi.nix
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
        ];

        generators = [ "sd-aarch64" ];

        deployment = {
          targetHost = ips.gradientnet.briah;
          tags = with colmena-tags; [ aarch64 raspberry-pi server vera ];
          allowLocalDeployment = true;
        };
      }
      
    ];
  };
}
