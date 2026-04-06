bindkey -e

autoload -U compinit && compinit

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
unsetopt APPEND_HISTORY
unsetopt EXTENDED_HISTORY
unsetopt HIST_EXPIRE_DUPS_FIRST
unsetopt HIST_FIND_NO_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS

alias ta="tmux attach"
alias ts="tmux-sessionizer"
alias la="ls -la"
alias vim="nvim"

export EDITOR="nvim"
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin"

setopt PROMPT_SUBST
PROMPT='%F{yellow}%~%f $ '

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# pnpm
export PNPM_HOME="/Users/raphael.weis/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
