let
  pkgsTarball = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  };
  pkgs = import pkgsTarball {
    config = {}; overlays = [];
  };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    texliveFull
    gnumake
  ];
}
