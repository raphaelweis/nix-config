{
  flake.modules.nixvimModules.conform =
    { lib, ... }:
    {
      plugins.conform-nvim = {
        enable = true;
        autoInstall.enable = true;
        settings = {
          formatters_by_ft = {
            nix = [
              "nixfmt"
              "injected"
            ];
            c = [ "clang-format" ];
            lua = [ "stylua" ];
            sh = [ "shfmt" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            json = [ "prettier" ];
            css = [ "prettier" ];
            html = [ "prettier" ];
            markdown = [ "prettier" ];
          };
          formatters = {
            injected = {
              options = {
                lang_to_ft = {
                  lua = "lua";
                  bash = "sh";
                };
              };
            };
          };
          default_format_opts = {
            lsp_format = "fallback";
          };
        };
      };
      keymaps = [
        {
          key = "<leader>fm";
          action = lib.nixvim.mkRaw /* lua */ "require('conform').format";
        }
      ];
    };
}
