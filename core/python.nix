{ config, pkgs, ... }:

let
  python-packages = p: with p; [
    (buildPythonPackage rec {
      pname = "jack-matchmaker";
      version = "0.10.0";
      src = fetchPypi {
        inherit pname version;
        sha256 = "70b8f53b0c75e8351ccdad4bf37bee8b544643604e0db1938ed749a4c0fa6ba6";
      };
      doCheck = false;
    })
  ];
in
{

  environment.systemPackages = with pkgs; [
    (python3.withPackages python-packages)
  ];

}