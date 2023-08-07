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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable-2211";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ss14-watchdog = {
      url = "github:space-wizards/SS14.Watchdog";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.stable.follows = "nixpkgs-stable-2305";
      inputs.flake-compat.follows = "flake-compat";
    };

    vdo-ninja = {
      url = "github:steveseguin/vdo.ninja";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, home-manager, gradient-generator, jovian-nixos, sops-nix, nixos-hardware, nixos-generators, ss14-watchdog, ... }:
  let
    ips = import ./misc/wireguard-addresses.nix;
    colmena-tags = import ./misc/colmena-tags.nix;
    mkFlake = (import ./lib/mkFlake.nix self);
    modules = import ./nixosModules.nix;
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

          modules.wine
          modules.podman
          modules.plymouth
          modules.uwu-style
          modules.vera-locale
          modules.virtualisation
          modules.nix-store-serve
          modules.aarch64-emulation
          modules.system76-scheduler

          modules.graphical
          modules.graphical-kde
          modules.graphical-steam
          modules.graphical-sunshine

          modules.pipewire
          modules.pipewire-um2
          modules.pipewire-virtual-sink
          modules.pipewire-low-latency

          modules.hardware-wacom
          modules.hardware-amdcpu
          modules.hardware-amdgpu
          modules.hardware-webcam
          modules.hardware-bluetooth
          modules.hardware-openrazer
          modules.hardware-home-dcp-l2530dw
          modules.hardware-xbox-one-controller
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
          ./users/vera/graphical
        ];

        deployment = {
          targetHost = ips.gradientnet.miracle-crusher;
          tags = with colmena-tags; [ x86_64 desktop vera ];
          allowLocalDeployment = true;
          buildOnTarget = true;
        };
      }

      {
        name = "neith-deck";
        overlays = [ jovian-nixos.overlays.default kernel-workaround ];

        modules = [
          sops-nix.nixosModules.sops
          jovian-nixos.nixosModules.default
          
          modules.wine
          modules.plymouth
          modules.uwu-style
          modules.neith-locale
          modules.nix-store-serve
          modules.system76-scheduler
          
          modules.graphical
          modules.graphical-kde
          modules.graphical-steam
          
          modules.pipewire
          modules.pipewire-virtual-sink
          modules.pipewire-low-latency
          
          modules.hardware-amdcpu
          modules.hardware-amdgpu
          modules.hardware-webcam
          modules.hardware-bluetooth
          modules.hardware-steamdeck
        ];

        users.neith.modules = [
          sops-nix.homeManagerModule
          ./users/neith/graphical
        ];

        deployment = {
          targetHost = ips.lilynet.neith-deck;
          tags = with colmena-tags; [ x86_64 steam-deck desktop neith ];
          allowLocalDeployment = true;
        };
      }

      {
        name = "vera-deck";
        overlays = [ jovian-nixos.overlays.default kernel-workaround ];

        modules = [
          sops-nix.nixosModules.sops
          jovian-nixos.nixosModules.default
          
          modules.wine
          modules.plymouth
          modules.uwu-style
          modules.vera-locale
          modules.virtualisation
          modules.nix-store-serve
          modules.system76-scheduler
          
          modules.graphical
          modules.graphical-kde
          modules.graphical-steam
          
          modules.pipewire
          modules.pipewire-virtual-sink
          modules.pipewire-low-latency
          
          modules.hardware-amdcpu
          modules.hardware-amdgpu
          modules.hardware-webcam
          modules.hardware-bluetooth
          modules.hardware-steamdeck
          modules.hardware-openrazer
          modules.hardware-home-dcp-l2530dw
          modules.hardware-xbox-one-controller
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
          ./users/vera/graphical
        ];

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
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-intel
          
          modules.podman
          modules.steamcmd
          modules.vera-locale
          modules.wine
          modules.virtualisation
          modules.nix-store-serve
          modules.aarch64-emulation
          modules.hardware-intelgpu-vaapi
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
        ];

        deployment = {
          tags = with colmena-tags; [ x86_64 server vera ];
          allowLocalDeployment = true;
        };
      }

       {
        name = "briah";
        system = "aarch64-linux";
        overlays = [ kernel-workaround ];
        
        modules = [
          ss14-watchdog.nixosModules.default
          sops-nix.nixosModules.sops

          modules.vera-locale
          modules.hardware-raspberrypi
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
        ];

        generators = [ "sd-aarch64" ];

        deployment = {
          targetHost = ips.gradientnet.briah;
          tags = with colmena-tags; [ aarch64 raspberry-pi server vera ];
          allowLocalDeployment = true;
          buildOnTarget = true; # cross-compile build breaks otherwise
        };
      }

      {
        name = "GradientOS-x86_64";
        system = "x86_64-linux";

        modules = [
          modules.graphical
          modules.graphical-kde
        ];

        generators = [ "install-iso" ];

        importHost = false;
        makeSystem = false;
      }

      {
        name = "GradientOS-x86_64-steamdeck";
        system = "x86_64-linux";
        overlays = [ jovian-nixos.overlays.default kernel-workaround ];

        modules = [
          jovian-nixos.nixosModules.default

          modules.graphical
          modules.graphical-kde
          modules.hardware-steamdeck
        ];

        generators = [ "install-iso" ];

        importHost = false;
        makeSystem = false;
      }
      
    ];

    nixosModules = modules;

  };
}
