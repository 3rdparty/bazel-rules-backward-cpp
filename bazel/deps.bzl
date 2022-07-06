"""Dependency specific initialization."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

_ALL_CONTENT = """\
filegroup(
    name = "all",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)
"""

def deps(repo_mapping = {}):
    rules_foreign_cc_dependencies()

    # Grab the latest version of all repos needed.
    maybe(
        http_archive,
        name = "rules_foreign_cc",
        url = "https://github.com/bazelbuild/rules_foreign_cc/archive/refs/tags/0.8.0.tar.gz",
        sha256 = "6041f1374ff32ba711564374ad8e007aef77f71561a7ce784123b9b4b88614fc",
        strip_prefix = "rules_foreign_cc-0.8.0",
        repo_mapping = repo_mapping,
    )

    maybe(
        http_archive,
        name = "com_github_texinfo",
        url = "https://ftp.gnu.org/gnu/texinfo/texinfo-6.8.tar.xz",
        build_file_content = _ALL_CONTENT,
        sha256 = "8eb753ed28bca21f8f56c1a180362aed789229bd62fff58bf8368e9beb59fec4",
        strip_prefix = "texinfo-6.8",
    )

    maybe(
        http_archive,
        name = "com_github_binutils",
        url = "https://ftp.gnu.org/gnu/binutils/binutils-2.38.tar.gz",
        build_file_content = _ALL_CONTENT,
        sha256 = "b3f1dc5b17e75328f19bd88250bee2ef9f91fc8cbb7bd48bdb31390338636052",
        strip_prefix = "binutils-2.38",
    )

    maybe(
        http_archive,
        name = "com_github_libunwind",
        url = "https://github.com/libunwind/libunwind/releases/download/v1.6.2/libunwind-1.6.2.tar.gz",
        build_file_content = _ALL_CONTENT,
        sha256 = "4a6aec666991fb45d0889c44aede8ad6eb108071c3554fcdff671f9c94794976",
        strip_prefix = "libunwind-1.6.2",
    )

    maybe(
        new_git_repository,
        name = "com_github_lzma",
        remote = "https://github.com/kobolabs/liblzma.git",
        build_file_content = _ALL_CONTENT,
        branch = "master",
    )

    maybe(
        http_archive,
        name = "com_github_backward_cpp",
        url = "https://github.com/bombela/backward-cpp/archive/refs/tags/v1.6.tar.gz",
        sha256 = "c654d0923d43f1cea23d086729673498e4741fb2457e806cfaeaea7b20c97c10",
        strip_prefix = "backward-cpp-1.6",
        repo_mapping = repo_mapping,
        build_file = "@com_github_3rdparty_bazel_rules_backward_cpp//:BUILD.bazel",
    )
