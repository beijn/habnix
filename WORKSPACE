load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


### { setup nixpgks and nix provided cc toolchian
# from https://github.com/tweag/rules_nixpkgs/blob/master/guide.md

# load rules_nixpkgs
http_archive(
    name = "io_tweag_rules_nixpkgs",  #BUMP
    sha256 = "b01f170580f646ee3cde1ea4c117d00e561afaf3c59eda604cf09194a824ff10",
    strip_prefix = "rules_nixpkgs-0.9.0",
    urls = ["https://github.com/tweag/rules_nixpkgs/archive/refs/tags/v0.9.0.tar.gz"],
)

# load everything that rules_nixpkgs rules need to work
load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")
rules_nixpkgs_dependencies()

# tell rules_nixpkgs to use nixpkgs generated from flake.nix and import collection into Bazel
load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_cc_configure", "nixpkgs_local_repository")
nixpkgs_local_repository(
    name = "nixpkgs",
    nix_file_content = """let
        lock = builtins.fromJSON (builtins.readFile ./flake.lock);
        spec = lock.nodes.nixpkgs.locked;
        nixpkgs = fetchTarball "https://github.com/${spec.owner}/${spec.repo}/archive/${spec.rev}.tar.gz";
      in import nixpkgs """,
    nix_file_deps = ["//:flake.lock"],
)

# make cc toolchain available form that nixpkgs
nixpkgs_cc_configure( name = "nixpkgs_config_cc", repository = "@nixpkgs" )

### }



### { setup haskell: rules_haskell, haskell toolchain and stackage snapshot
# requires nixpkgs and cc toolchain from rules_nixpkgs stuff above

# get rules haskell: https://rules-haskell.readthedocs.io/en/latest/haskell-use-cases.html#making-rules-haskell-available
http_archive(
    name = "rules_haskell",  #BUMP
    sha256 = "2a07b55c30e526c07138c717b0343a07649e27008a873f2508ffab3074f3d4f3",
    strip_prefix = "rules_haskell-0.16",
    url = "https://github.com/tweag/rules_haskell/archive/refs/tags/v0.16.tar.gz",
)
load("@rules_haskell//haskell:repositories.bzl", "rules_haskell_dependencies")
rules_haskell_dependencies()

## rules_haskell needs python :/
load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_python_configure")
nixpkgs_python_configure( repository = "@nixpkgs" )


## declare GHC version and haskell toolchain: https://rules-haskell.readthedocs.io/en/latest/haskell-use-cases.html#picking-a-compiler
# change: nixpkgs declared above
load("@rules_haskell//haskell:nixpkgs.bzl", "haskell_register_ghc_nixpkgs")
haskell_register_ghc_nixpkgs(
    version = "9.4.5",  #BUMP this and attribute_path according to HLS: https://haskell-language-server.readthedocs.io/en/latest/support/ghc-version-support.html
    attribute_path = "haskell.compiler.ghc94",
    repositories = {"nixpkgs": "@nixpkgs"},
)

## declare @stackage as a source for haskell packages
load("@rules_haskell//haskell:cabal.bzl", "stack_snapshot")
stack_snapshot(
    stack_snapshot_json = "//:stackage_snapshot.json", # Unpinned stack_snapshot invokes stack on every build. Pin stackage depts: run `bazel run @stackage-unpinned//:pin` and uncomment this line.
    name = "stackage",
    local_snapshot = "//:stackage.lts-21.6.yaml",
    # snapshot = "lts-21.6",  # non-local snapshot makes bazel download its own copy of stack (not using nix!!). Using nix provided stack downloads looads of haskell deps... | In the end bazel still downloads stack! why?
    packages = ["relude"],
)

### }
