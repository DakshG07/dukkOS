# My NixOS Config
This is NOT a complete NixOS configuration. I use NixOS through WSL in Windows, so this entire config is for the CLI only. If you live in the CLI, then great!

## Installation
Follow the instructions [here](https://github.com/nix-community/NixOS-WSL) to install NixOS through WSL. Then, set a password, clone this repo and run the installer:

```bash
$ sudo passwd nixos
$ nix-shell -p git
$ git clone https://github.com/DakshG07/nix-stuff ~/.nix
$ cd ~/.nix
$ chmod +x install.sh
$ sudo ./install.sh
$ sudo passwd dukk
```

You'll need to set up passwords for stuff to work. After that, exit WSL and re-enter. You should now be logged into a starship session.
