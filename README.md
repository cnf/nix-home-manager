# Nix home-manager configuration

```shell
$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
$ nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
$ nix-channel --update
$ nix-shell '<home-manager>' -A install
```
