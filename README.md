# halgenthq/homebrew-tap

Homebrew formula for [halgent](https://halgent.com), a control layer between AI agents and the tools they use. It records the tool calls of Claude Code and Codex sessions, checks them against rules, and can block them.

## Install

```sh
brew install halgenthq/tap/halgent
```

`brew install halgent` does not work: homebrew-core accepts only open-source software, so halgent ships from this tap.

`halgent run -- claude` also needs sandbox-runtime (`srt`) from npm, and on Linux bubblewrap from your system packages. Brew cannot install them, so it prints the exact commands after the install. Then check the machine:

```sh
halgent doctor
```

Without Homebrew (Linux, CI, a Mac without brew), use the install script, which installs the dependencies too:

```sh
curl --proto '=https' --tlsv1.2 -fsSL https://halgent.com/install.sh | sh
```

## Update and remove

```sh
brew upgrade halgent
brew uninstall halgent && brew untap halgenthq/tap
```

A running `halgent run` session keeps its own copy of the binary, so an upgrade never changes or breaks it.

## What the formula installs

One binary, `halgent`, for macOS and Linux on arm64 and amd64. The archives are downloaded from `https://dl.halgent.com/halgent/v<version>/` and checked against the sha256 in [Formula/halgent.rb](Formula/halgent.rb). The macOS binaries are not notarized. Brew does not quarantine formula downloads, so they run without a Gatekeeper prompt.

## How this tap changes

The formula changes only through pull requests opened by the release script and reviewed and merged by the maintainer. Nobody pushes to `main` directly. Each release PR lists the URLs and sha256 values, which match the `checksums.txt` published with that release.

## Problems

Open an issue in this repository.
