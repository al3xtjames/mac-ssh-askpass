# mac-ssh-askpass

(Incomplete) `ssh-askpass(1)` implementation for macOS.

This only implements support for `SSH_ASKPASS_PROMPT=none`, which is used for
[U2F touch reminders][1].

<img src="/.github/readme/screenshot.png" alt="Screenshot of mac-ssh-askpass U2F touch reminder" width="328">

### Compilation

mac-ssh-askpass uses the Swift Package Manager for compilation:

```shell
$ swift build -c release
```

This repo also includes a Nix derivation, along with a flake that defines
packages for `aarch64-darwin` and `x86_64-darwin`.

### Usage

The following environment variables need to be set for `ssh` to use askpass:

- [`SSH_ASKPASS`][3]:         Should be set to the name of the mac-ssh-askpass
                              binary (if it's in `PATH`). An absolute path can
                              also be used.
- [`SSH_ASKPASS_REQUIRE`][3]: Should be set to `force` as macOS doesn't set
						      `DISPLAY`.

For U2F, `ssh` will only use askpass for agent signing requests. You'll need to
add your ED25519-SK/ECDSA-SK keys to an agent and configure `ssh` to use your
agent. Note that as of macOS 13, the built-in `ssh-agent` [doesn't support
ED25519-SK/ECDSA-SK keys][4].

#### Workaround for host key verification failures

Note that `ssh` uses `ssh-askpass(1)` to confirm host key fingerprints. As
`mac-ssh-askpass` doesn't support this, host key verification will fail with
`Host key verification failed.`.

As a workaround, this repo includes [a patch for openssh-portable][5] (currently
for 9.8p1) to support `SSH_ASKPASS_REQUIRE=notify-force`. When this environment
variable is set, `ssh-askpass(1)` will only be used for U2F notifications. Other
prompts (including those for host key verification) will use the terminal.

[1]: https://lists.mindrot.org/pipermail/openssh-unix-dev/2019-November/038032.html
[2]: https://www.swift.org/package-manager/
[3]: https://man.openbsd.org/ssh-add.1#DISPLAY
[4]: https://developer.apple.com/forums/thread/698683
[5]: ssh-askpass-require-notify-force.patch
