load(
    "@rules_haskell//haskell:defs.bzl",
    "haskell_toolchain_library",
    "haskell_library",
    "haskell_binary",
)

# haskell_toolchain_library(name = "base") # haskell_toolchain_library can access builtin GHC packages

haskell_library(
    name = "mainlib",
    srcs = glob(['**/*.hs']),
    deps = ["@stackage//:relude"],
)

haskell_binary(
    name = "main",
    srcs = [":Main.hs"],
    deps = [":mainlib", "@stackage//:relude"],
)
