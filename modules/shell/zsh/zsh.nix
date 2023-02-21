{ pkgs, lib, config, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      dotDir = ".config/zsh";
      shellAliases = {
        la = "ls -la";
      };

      plugins = with pkgs; [
        {
          file = "powerlevel10k.zsh-theme";
          name = "powerlevel10k";
          src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
        }
        {
          file = ".p10k.zsh";
          name = "powerlevel10k-config";
          src = ../shell;
        }
      ];
      initExtraBeforeCompInit = ''
        # p10k instant prompt
        local P10K_INSTANT_PROMPT="${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
        [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      '';
    };
  };
}