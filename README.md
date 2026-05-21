# homebrew-far2l

A Homebrew tap providing **`far2l-tty-full`** — the FAR Manager v2 Unix TTY
port built with the complete feature set: Python plugin, all NetRocks
network protocols (SFTP, FTP, SMB, NFS, WebDAV, AWS S3, SHELL), and X11
clipboard integration.

This is a feature-superset of the `far2l-tty` formula in `homebrew-core`,
which ships with Python and SMB/AWS disabled.

## Install

```sh
brew install Vladekk/far2l/far2l-tty-full
```

This taps `Vladekk/far2l` and installs the formula in one step. If you
prefer the steps separate:

```sh
brew tap Vladekk/far2l
brew install far2l-tty-full
```

## Conflict with `far2l-tty`

`far2l-tty-full` and the upstream `far2l-tty` install the same binaries
(`far2l`, `far2ledit`, etc.) and cannot both be linked at the same time.
If `far2l-tty` is already linked when you install this formula, the
install will succeed (the files land in the Cellar) but the post-install
`brew link` step will fail with a conflict.

Resolve it by unlinking the other formula and linking this one:

```sh
brew unlink far2l-tty
brew link --overwrite far2l-tty-full
```

To switch back later:

```sh
brew unlink far2l-tty-full
brew link far2l-tty
```

## Upgrade / uninstall

```sh
brew upgrade far2l-tty-full
brew uninstall far2l-tty-full
brew untap Vladekk/far2l        # remove the tap entirely
```

## Build notes

The formula has been built and tested on Linux (Homebrew on Linux,
`linuxbrew`). It should also build on macOS — the X11 deps and explicit
`FindX11` paths are gated to Linux via `on_linux do` — but a macOS build
has not been verified yet.

The "full" build pulls in some heavy dependencies that the core formula
deliberately avoids: `python@3.12`, `samba` (libsmbclient), and
`aws-sdk-cpp` (~750 MB). If you don't need SMB or S3, the core
`far2l-tty` is the smaller choice.
