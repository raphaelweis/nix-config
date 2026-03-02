{
  flake.modules.nixvimModules.telescope = {
    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
        };
        extensions = {
          fzf-native.enable = true;
        };
      };
      web-devicons.enable = true;
    };
  };
}
