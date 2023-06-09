## GradientOS
Flake for different NixOS system configurations.

### Features
- Encrypted secrets using [sops-nix](https://github.com/Mic92/sops-nix)
- Optional Steam Deck support using [Jovian NixOS](https://github.com/Jovian-Experiments/Jovian-NixOS)
- Supports deployments using [Colmena](https://github.com/zhaofengli/colmena)
- Spaghetti!

### Overview
- **core**: configurations that are shared across all machines
- **hardware**: configurations specific to certain hardware
- **hosts**: configurations specific to certain machines
- **lib**: utility functions
- **misc**: for files without a clear category
- **modules**: modular configurations for certain programs and services
- **modules/graphical**: modular configurations for certain graphical programs and services
- **modules/home**: modular configurations for certain programs and services, using [home-manager](https://github.com/nix-community/home-manager)
- **pkgs**: nixpkgs overlays and custom packages
- **users**: configurations specific to certain users, using [home-manager](https://github.com/nix-community/home-manager)
- **users/common**: configurations shared across all users, using [home-manager](https://github.com/nix-community/home-manager)

### Machines

- **miracle-crusher**: Gaming desktop.
- **vera-deck**: Steam Deck.
- **neith-deck**: Steam Deck.
- **asiyah**: Azure Virtual Machine Server.
- **briah**: Raspberry Pi 4 Server.
- **atziluth**: Server. *WIP*