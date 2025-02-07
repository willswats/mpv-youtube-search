{
  description = "mpv-youtube-search";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          mpv-youtube-search = pkgs.callPackage ./default.nix { };
          default = self.packages.${system}.mpv-youtube-search;
        };
      }
    );
}
