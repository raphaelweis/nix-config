# My nixos configurations

![The nixos logo on a white background](./assets/nixos-logo-black.svg#gh-light-mode-only)
![The nixos logo on a black background](./assets/nixos-logo-white.svg#gh-dark-mode-only)

This repository contains nixos configurations for my personal computers. it currently
supports 2 hosts, my laptop and my desktop.

## Structure

This configuration uses the [dentritic pattern](https://github.com/mightyiam/dendritic), or at least my interpretation of it.
To implement it, I used the following ressources:

- [Mightyjam's dentritic repository](https://github.com/mightyiam/dendritic)
- [Doc Steve's guide on dentritic design with flake parts](https://github.com/Doc-Steve/dendritic-design-with-flake-parts)
- [Gaetan Lepage's nix config](https://github.com/GaetanLepage/nix-config)
- [Drupol's 'Refactoring My Infrastructure As Code Configurations' article](https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations)
- [Drupol's infra repository](https://github.com/drupol/infra)

All of the nix code is in the `modules` directory, and imported automatically using
[Vic's import-tree](https://github.com/vic/import-tree)

The structure is as follows:

```
├── assets # external assets such as pictures and fonts
└── modules # all flake-parts modules
    ├── desktop # desktop environment related configuration (cursor config, xdg config, ...)
    ├── hosts # per host configuration
    │   ├── desktop # my personal desktop
    │   └── laptop # my personal laptop
    ├── programs # programs to enable and their optional configuration
    ├── services # standalone services or daemons
    └── system # system-level configuration (bootloader, bluetooth, ...)
```

Every file is a 'feature' in dentritic terms, and each type of feature is
highlighted
by the different directories.

## Tools I use

| **Tool**            | **Name**                               |
| ------------------- | -------------------------------------- |
| Web browser         | [zen-browser](https://zen-browser.app) |
| Desktop environment | [Gnome](https://www.gnome.org)         |
| Terminal emulator   | [Ghostty](https://ghostty.org)         |
| Shell               | [zsh](https://zsh.org)                 |
| Code editor         | [Neovim](https://neovim.io)            |

Here is a screenshot of my current system:
![a screenshot of my current desktop with a terminal containing a neofetch output](./assets/desktop_screenshot_28-02-26.png)
