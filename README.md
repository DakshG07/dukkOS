# DukkOS
Tired of crappy operating systems like Windows and MacOS, but don't want to settle for mainstream Linux? Try DukkOS!

What you get:
- Misuse of the term "OS"
- NixOS, also known as "esoteric dotfiles"
- Random bloat pre-installed that you may never use

What's in the box:
- ~~Hyprland~~ XMonad so you can show off to your friends.
- KDE, for when you want to be productive.
- Vivaldi *and* Firefox, in case you lack commitment.
- Neovim, the real developer's text editor ™
- A config that *could* be much cleaner but is intead stuck in a perpetual "good enough"

Need I say more?
To install, simply clone the flake, and run (from the flake directory):
```sh
sudo nixos-rebuild switch --flake ".#nixos"
```

The old Windows config is available in the [`old-wsl`](https://github.com/DakshG07/nix-stuff/tree/old-wsl) branch, for those who suffer from seperation anxiety.
