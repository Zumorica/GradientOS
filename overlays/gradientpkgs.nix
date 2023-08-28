/*
*   Overlay with packages that can be consumed without using a GradientOS configuration.
*/
final: prev:
{
  jack-matchmaker = prev.callPackage ../pkgs/jack-matchmaker.nix { };

  starsector-gamescope-wrap = prev.callPackage ../pkgs/starsector-gamescope-wrap.nix { }; 

  tinypilot = prev.callPackage ../pkgs/tinypilot.nix { };

  xwaylandvideobridge = prev.libsForQt5.callPackage ../pkgs/xwaylandvideobridge.nix { };

}