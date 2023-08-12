# load the http_archive rule itself
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# load rules_nixpkgs
http_archive(
    name = "io_tweag_rules_nixpkgs",
    sha256 = "b01f170580f646ee3cde1ea4c117d00e561afaf3c59eda604cf09194a824ff10",
    strip_prefix = "rules_nixpkgs-0.9.0",
    urls = ["https://github.com/tweag/rules_nixpkgs/archive/refs/tags/v0.9.0.tar.gz"],
)

# load everything that rules_nixpkgs rules need to work
load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")

rules_nixpkgs_dependencies()

# Now we can tell rules_nixpkgs to use our nixpkgs.nix above to import this Nixpkgs collection into Bazel
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

nixpkgs_cc_configure(
    name = "nixpkgs_config_cc",
    repository = "@nixpkgs",
)
