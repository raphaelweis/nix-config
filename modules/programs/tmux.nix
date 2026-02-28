{
  flake.modules.homeManager.tmux =
    { pkgs, ... }:
    {
      programs.tmux = {
        enable = true;
        keyMode = "vi";
        disableConfirmationPrompt = true;
        clock24 = true;
        terminal = "screen-256color";
        newSession = true;
        plugins = with pkgs.tmuxPlugins; [
          vim-tmux-navigator
          prefix-highlight
          resurrect
        ];
        extraConfig = # tmux
          ''
            set-option -sg escape-time 10
            set-option -g focus-events on
            set-option -a terminal-features 'alacritty:RGB'

            # keybinds
            bind c new-window -c "#{pane_current_path}"
            bind '"' split-window -c "#{pane_current_path}"
            bind % split-window -h -c "#{pane_current_path}"
            bind -T copy-mode-vi v send-keys -X begin-selection
            bind -T copy-mode-vi y send-keys -X copy-selection

            set -g status on
            set -g mouse on
            set -g status-position 'top'
            set -g status-interval 1
            set -g status-left-length 100
            set -g status-right-length 100
            set -g status-style "fg=white"
            set -g status-justify absolute-centre
            set -g message-style "fg=black,bg=cyan"
            set -g window-status-current-style fg=yellow,bg=default,bold
            set -g status-left ""
            set -g status-right "[#S]"
            set -g @prefix_highlight_output_prefix "#[fg=black]#[bg=yellow]"
            set -g @prefix_highlight_output_suffix ""
          '';

      };
      home.packages =
        let
          tmux-sessionizer = pkgs.writeShellScriptBin "tmux-sessionizer" ''
            #!/usr/bin/env bash

            if [[ $# -eq 1 ]]; then
              selected=$1
            else
              selected=$(
                {
                  find ~/D ~/W -mindepth 1 -maxdepth 1 -type d
                  printf '%s\n' "$HOME/.dotfiles"
                } | fzf
              )
            fi

            if [[ -z $selected ]]; then
              exit 0
            fi

            selected_name=$(basename "$selected" | tr . _)
            tmux_running=$(pgrep tmux)

            if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
              tmux new-session -s $selected_name -c $selected
              exit 0
            fi

            if ! tmux has-session -t=$selected_name 2>/dev/null; then
              tmux new-session -ds $selected_name -c $selected
            fi

            if [[ -z $TMUX ]]; then
              tmux attach -t $selected_name
            else
              tmux switch-client -t $selected_name
            fi
          '';
        in
        [ tmux-sessionizer ];
    };
}
