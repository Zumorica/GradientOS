{
  description = "GradientOS flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable-2305.url = "github:NixOS/nixpkgs/nixos-23.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    mobile-nixos = {
      url = "github:NixOS/mobile-nixos";
      flake = false;
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    };

    gradient-moe = {
      url = "git+ssh://git@github.com/Zumorica/gradient.moe";
      flake = false;
    };

    constellation-moe = {
      url = "git+ssh://git@github.com/ConstellationNRV/constellation.moe";
      flake = false;
    };

    jovian-nixos = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable-2305";
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

    declarative-flatpak.url = "github:GermanBread/declarative-flatpak/stable";

    vdo-ninja = {
      url = "github:steveseguin/vdo.ninja/v23.5";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, home-manager, gradient-generator, jovian-nixos, sops-nix, nixos-hardware, nixos-generators, ss14-watchdog, declarative-flatpak, ... }:
  let
    ips = import ./misc/wireguard-addresses.nix;
    colmena-tags = import ./misc/colmena-tags.nix;
    mkFlake = (import ./lib/mkFlake.nix self);
    mixins = import ./nixosMixins.nix;
    modules = import ./nixosModules.nix;
  in
  mkFlake {

    gradientosConfigurations = [
        
      {
        name = "miracle-crusher";

        modules = [
          sops-nix.nixosModules.sops
          declarative-flatpak.nixosModules.default
          nixos-hardware.nixosModules.common-cpu-amd-pstate

          mixins.wine
          mixins.podman
          mixins.plymouth
          mixins.uwu-style
          mixins.upgrade-diff
          mixins.v4l2loopback
          mixins.vera-locale
          mixins.virtualisation
          mixins.nix-store-serve
          mixins.aarch64-emulation
          mixins.system76-scheduler
          mixins.declarative-flatpak

          mixins.graphical
          mixins.graphical-kde
          mixins.graphical-steam
          mixins.graphical-gamescope
          mixins.graphical-sunshine

          mixins.pipewire
          mixins.pipewire-um2
          mixins.pipewire-rnnoise
          mixins.pipewire-virtual-sink
          mixins.pipewire-low-latency

          mixins.hardware-qmk
          mixins.hardware-wacom
          mixins.hardware-amdcpu
          mixins.hardware-amdgpu
          mixins.hardware-webcam
          mixins.hardware-bluetooth
          mixins.hardware-openrazer
          mixins.hardware-home-dcp-l2530dw
          mixins.hardware-xbox-one-controller
          mixins.hardware-logitech-driving-wheels
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
          ./users/vera/graphical/default.nix
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
        overlays = [ self.overlays.kernel-allow-missing ];

        modules = [
          sops-nix.nixosModules.sops
          jovian-nixos.nixosModules.default
          declarative-flatpak.nixosModules.default

          mixins.wine
          mixins.plymouth
          mixins.uwu-style
          mixins.upgrade-diff
          mixins.v4l2loopback
          mixins.neith-locale
          mixins.nix-store-serve
          mixins.system76-scheduler
          mixins.declarative-flatpak
          
          mixins.graphical
          mixins.graphical-kde
          mixins.graphical-steam
          
          mixins.pipewire
          mixins.pipewire-virtual-sink
          mixins.pipewire-low-latency
          
          mixins.hardware-amdcpu
          mixins.hardware-amdgpu
          mixins.hardware-webcam
          mixins.hardware-bluetooth
          mixins.hardware-steamdeck
        ];

        users.neith.modules = [
          sops-nix.homeManagerModule
          ./users/neith/graphical/default.nix
        ];

        deployment = {
          targetHost = ips.lilynet.neith-deck;
          tags = with colmena-tags; [ x86_64 steam-deck desktop neith ];
          allowLocalDeployment = true;
        };
      }

      {
        name = "vera-deck";
        overlays = [ self.overlays.kernel-allow-missing ];

        modules = [
          sops-nix.nixosModules.sops
          jovian-nixos.nixosModules.default
          declarative-flatpak.nixosModules.default
          
          mixins.wine
          mixins.plymouth
          mixins.uwu-style
          mixins.vera-locale
          mixins.upgrade-diff
          mixins.v4l2loopback
          # TODO: fix mixins.mobile-stage1
          mixins.virtualisation
          mixins.nix-store-serve
          mixins.system76-scheduler
          mixins.declarative-flatpak
          
          mixins.graphical
          mixins.graphical-kde
          mixins.graphical-steam
          
          mixins.pipewire
          mixins.pipewire-virtual-sink
          mixins.pipewire-low-latency
          
          mixins.hardware-qmk
          mixins.hardware-amdcpu
          mixins.hardware-amdgpu
          mixins.hardware-webcam
          mixins.hardware-bluetooth
          mixins.hardware-steamdeck
          mixins.hardware-openrazer
          mixins.hardware-home-dcp-l2530dw
          mixins.hardware-xbox-one-controller
        ];

        users.vera.modules = [
          sops-nix.homeManagerModule
          ./users/vera/graphical/default.nix
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
          gradient-generator.nixosModules.x86_64-linux.default


          mixins.wine
          mixins.podman
          mixins.steamcmd
          mixins.vera-locale
          mixins.upgrade-diff
          mixins.v4l2loopback
          mixins.virtualisation
          mixins.nix-store-serve
          mixins.aarch64-emulation
          mixins.hardware-intelgpu-vaapi
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
        overlays = [ self.overlays.kernel-allow-missing ];
        
        modules = [
          ss14-watchdog.nixosModules.default
          sops-nix.nixosModules.sops

          mixins.plymouth

          mixins.vera-locale
          mixins.upgrade-diff
          mixins.v4l2loopback
          mixins.hardware-raspberrypi4
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
          mixins.graphical
          mixins.graphical-kde
        ];

        generators = [ "install-iso" ];

        importHost = false;
        makeSystem = false;
      }

      {
        name = "GradientOS-x86_64-steamdeck";
        system = "x86_64-linux";
        overlays = [ jovian-nixos.overlays.default self.overlays.kernel-allow-missing ];

        modules = [
          jovian-nixos.nixosModules.default

          mixins.graphical
          mixins.graphical-kde
          mixins.hardware-steamdeck
        ];

        generators = [ "install-iso" ];

        importHost = false;
        makeSystem = false;
      }
      
    ];

    nixosModules = modules // (nixpkgs.lib.attrsets.mapAttrs' (name: value: { name = "mixin-" + name; inherit value; }) mixins);

    overlays = {
      default = self.overlays.gradientpkgs;
      gradientpkgs = import ./overlays/gradientpkgs.nix;
      gradientos = import ./overlays/gradientos.nix self;
      kernel-allow-missing = import ./overlays/kernel-allow-missing.nix;
    };

    packages = self.lib.forAllSystems (pkgs: self.overlays.gradientpkgs pkgs pkgs);

  };
}
