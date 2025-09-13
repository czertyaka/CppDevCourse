let
  pkgsTarball = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
    sha256 = "0555pg9zcr3aazyxqb6g6q8vq3lc5zz3rnqx8ga1i3bs2q04yb4q";
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
