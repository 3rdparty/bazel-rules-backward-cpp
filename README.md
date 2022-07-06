![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black) ![MacOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)

# bazel-rules-backward-cpp
Bazel build rules for https://github.com/bombela/backward-cpp

## For now we only support Linux and macOS and the support for Windows might be added in the future.

Follows a "repos/deps" pattern (in order to help with recursive dependencies). To use:

1. Copy `bazel/repos.bzl` into your repository at `3rdparty/bazel-rules-backward-cpp/repos.bzl` and add an empty `BUILD` (or `BUILD.bazel`) to `3rdparty/bazel-rules-backward-cpp` as well.

2. Copy all of the directories from `3rdparty` that you ***don't*** already have in ***your*** repository's `3rdparty` directory.

3. Add the following to your `WORKSPACE` (or `WORKSPACE.bazel`):

```bazel
load("//3rdparty/bazel-rules-backward-cpp:repos.bzl", backward_repos="repos")
backward_repos()
load("@com_github_3rdparty_bazel_rules_backward_cpp//bazel:deps.bzl", backward_deps="deps")
backward_deps()
```

Or ... to simplify others depending on ***your*** repository, add the following to your `repos.bzl`:

```bazel
load("//3rdparty/bazel-rules-backward-cpp:repos.bzl", backward_repos="repos")
def repos():
    backward_repos()
```

And the following to your `deps.bzl`:

```bazel
load("@com_github_3rdparty_bazel_rules_backward_cpp//bazel:deps.bzl", backward_deps="deps")
def deps():
    backward_deps()
```

4. You can then use `@com_github_backward_cpp//:backward` in your target's `deps`.
