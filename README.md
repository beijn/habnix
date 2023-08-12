# Bazel inside Nix with hermetic C-toolchain
project seed

## Setup a Nix based development environment

- install nix the better way: https://github.com/DeterminateSystems/nix-installer

- basic shell flake & direnv: https://github.com/tweag/rules_nixpkgs/blob/master/guide.md
  - installed nix-direnv: https://github.com/nix-community/nix-direnv
  - `nix flake init`
  - edit flake
  - `nix flake update`

## Setup Bazel inside Nix with rules_nixpkgs
for a nix to provide bazel and a hermit c toolchain

- following https://github.com/tweag/rules_nixpkgs/blob/master/guide.md
- ! added an empty `BUILD` to repo root
- put the content of `nixpkgs.nix` in `WORKSPACE → nixpkgs_local_repository → nix_file` **`_content`**


