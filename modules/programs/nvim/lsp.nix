{
  flake.modules.nixvimModules.lsp = {
    plugins.lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        clangd.enable = true;
        ts_ls.enable = true;
        eslint.enable = true;
        cssls.enable = true;
        html.enable = true;
        jsonls.enable = true;
      };
    };
  };
}
