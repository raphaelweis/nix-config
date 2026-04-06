{
  flake.modules.nixos.cmdline-pkgs =
    { pkgs, ... }:
    {
      environment.systemPackages =
        with pkgs;
        [
          vim
          killall
          xclip
          ripgrep
          fd
          gcc
          nodejs
          pnpm
          rlwrap
          chntpw
          acpi
          google-cloud-sdk
          sops
          age
          typst
          file
          jq
          gnumake
          tree
          ollama
          opencode
          fzf
          neovim
          stow
          gh

          # editor tools (lsp, formatters, etc)
          lua-language-server
          tree-sitter
          nixd
          stylua
          prettierd
          ruff
          pyright
          vtsls
          nixfmt
        ]
        ++ [ (pkgs.callPackage ../packages/vscode-langservers-extracted.nix { }) ];
    };
}
