# My NixOS configurations + dotfiles

![The nixos logo on a white background](./assets/nixos-logo-black.svg#gh-light-mode-only)
![The nixos logo on a black background](./assets/nixos-logo-white.svg#gh-dark-mode-only)

This repository contains NixOS configurations for my personal computers / servers.

It contains nixos configurations for the following hosts:

| **Host name** | **Type** | **Comment**                |
| ------------- | -------- | -------------------------- |
| interstellar  | desktop  | My personal laptop         |
| john          | desktop  | My personal desktop        |
| nanorion      | server   | Scaleway bare metal server |

It also contains my dotfiles, that I manage with [GNU stow](https://www.gnu.org/software/stow/).
I don't manage my dotfiles with nix because I have a work machine I can't use
nix on, so I just keep the dotfiles separate.

## Structure

The nix part of this repo uses the [dentritic pattern](https://github.com/mightyiam/dendritic), or at least my interpretation of it.
To implement it, I used the following ressources:

- [Mightyjam's dentritic repository](https://github.com/mightyiam/dendritic)
- [Doc Steve's guide on dentritic design with flake parts](https://github.com/Doc-Steve/dendritic-design-with-flake-parts)
- [Gaetan Lepage's nix config](https://github.com/GaetanLepage/nix-config)
- [Drupol's 'Refactoring My Infrastructure As Code Configurations' article](https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations)
- [Drupol's infra repository](https://github.com/drupol/infra)

All of the nix code is in the `modules` directory, and imported automatically using
[Vic's import-tree](https://github.com/vic/import-tree)

In the modules directory, every file is a 'feature' in dentritic terms, and each type of feature is
highlighted
by the different directories. A feature may apply to personal computers, to servers
or to both. When a feature has specific configuration for the server machine type,
the associated module is suffixed with `-server` (example: [`boot.nix`](./modules/system/boot.nix))

The dotfiles are contained in the `dotfiles` directory. The structure of the directory
follows the structure of my home directory, allowing me to run:

```
stow -t ~ dotfiles
```

To symlink my dotfiles.

| **Tool**            | **Name**                               |
| ------------------- | -------------------------------------- |
| Web browser         | [zen-browser](https://zen-browser.app) |
| Desktop environment | [Gnome](https://www.gnome.org)         |
| Terminal emulator   | [Ghostty](https://ghostty.org)         |
| Shell               | [zsh](https://zsh.org)                 |
| Code editor         | [Neovim](https://neovim.io)            |

Here is a screenshot of my current system:
![a screenshot of my current desktop with a terminal containing a neofetch output](./assets/desktop_screenshot_28-02-26.png)

## Rebuild commands

For desktop configurations:

```bash
sudo nixos-rebuild switch --flake .#<configuration-name>
```

For server configurations:

```bash
nixos-rebuild switch --flake .#<configuration-name> --target-host "root@<server-ip>"
```
