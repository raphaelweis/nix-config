{
  flake.modules.homeManager.zsh = {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
      initContent = # bash
        ''
          alias ta="tmux attach"
          alias ts="tmux-sessionizer"
          alias la="ls -la"
          alias ns="nix-shell --run zsh"

          export EDITOR="nvim"

          setopt PROMPT_SUBST
          PROMPT='%F{yellow}%~%f $ '
        '';
    };
  };
}
