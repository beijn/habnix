{
  description = "Development environment for Haskell with VSCode using Bazel inside Nix";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShellNoCC
          {
            name = "rules_nixpkgs_shell";

            packages = with pkgs; [ bazel bazel-buildtools nix git ]; 
          };
      });
}
