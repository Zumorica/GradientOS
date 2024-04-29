## GradientOS
Flake for different NixOS system configurations.

# GradientOS supports the [aux.computer](https://aux.computer/) project and so should you!

### Features
- Encrypted secrets using [sops-nix](https://github.com/Mic92/sops-nix)
- Optional Steam Deck support using [Jovian NixOS](https://github.com/Jovian-Experiments/Jovian-NixOS)
- Supports deployments using [Colmena](https://github.com/zhaofengli/colmena)
- Spaghetti!

### Overview
- **[core](core)**: configurations that are shared across all machines
- **[hosts](hosts)**: configurations specific to certain machines
- **[lib](lib)**: utility functions
- **[misc](misc)**: for files without a clear category
- **[mixins](mixins)**: configuration presets for certain programs and services
- **[mixins/graphical](mixins/graphical)**: configuration presets for certain graphical programs and services
- **[mixins/hardware](mixins/hardware)**: configuration presets specific to certain hardware
- **[mixins/home](mixins/home)**: configuration presets for certain programs and services, using [home-manager](https://github.com/nix-community/home-manager)
- **[mixins/pipewire](mixins/pipewire)**: configuration presets for Pipewire
- **[modules](modules)**: custom NixOS modules
- **[overlays](overlays)**: nixpkgs overlays
- **[pkgs](pkgs)**: custom packages
- **[users](users)**: configurations specific to certain users, using [home-manager](https://github.com/nix-community/home-manager)
- **[users/common](users/common)**: configurations shared across all users, using [home-manager](https://github.com/nix-community/home-manager)

### Modules
- **[default](modules/default.nix)**: imports every other module in this list
- **[tmpfiles-check](modules/tmpfiles-check.nix)**: support for system-reproducibility-breaking, declarative mutable files using tmpfiles.d

### Machines

- **[miracle-crusher](hosts/miracle-crusher)**: Custom Gaming Desktop.
- **[vera-deck](hosts/vera-deck)**: Steam Deck LCD.
- **[vera-deck-oled](hosts/vera-deck-oled)**: Steam Deck OLED.
- **[neith-deck](hosts/neith-deck)**: Steam Deck LCD.
- **[asiyah](hosts/asiyah)**: ThinkCentre M900 Tiny Home Server.
- **[briah](hosts/briah)**: Raspberry Pi 4 Home Server.
<!-- - **atziluth**: Server. *WIP* -->

### FAQ

> Should I use this on my machine?

No, these configurations make many assumptions about the hardware they are running on, so they will not work on your machine.<br>
Feel free to take inspiration from them or modify them so they work for you, though!

> Should I expect this flake's outputs to be stable?

No, always expect breaking changes. You might be better off copying whatever you need into your config rather than consuming this flake directly.<br>
Just don't forget to leave a comment with attribution and this project's license!

