# Compile Haskell using Bazel inside Nix

- started from the _Bazel inside Nix_ template github.com/beijn/baznix

## Setup rules_haskell to compile Haskell using Bazel
- inspired by https://rules-haskell.readthedocs.io/en/latest/haskell.html 
- and https://rules-haskell.readthedocs.io/en/latest/haskell-use-cases.html 
- and `$ sh <(curl https://haskell.build/start) --use-nix`
- scrapped zlib external c stuff
- changed ghc version & stackage version
- changed prelude to relude