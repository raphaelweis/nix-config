{
  flake.modules.nixvimModules.completion = {
    opts.completeopt = [
      "menu"
      "menuone"
      "noselect"
    ];
    plugins.blink-cmp = {
      enable = true;
      settings = {
        sources.default = [
          "lsp"
          "path"
          "buffer"
        ];
        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 0;
          };
          menu = {
            border = "none";
          };
        };
      };
    };
  };
}
