### changing directories
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

### functions
fpath=($HOME/dotfiles/zsh/functions $fpath)

### completion
fpath=($HOME/dotfiles/zsh/completion $HOME/dev/*/completions $fpath)
autoload -Uz compinit
compinit -i

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh-cache

setopt always_to_end
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_remove_slash
setopt complete_in_word
setopt extended_glob

### history
command_oriented_history=1
HISTCONTROL=ignoreboth

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=8192
export SAVEHIST=8192

setopt append_history
setopt bang_hist
setopt extended_history
setopt hist_beep
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify

### job control
setopt auto_resume
unsetopt bg_nice
unsetopt check_jobs
unsetopt hup
setopt long_list_jobs
setopt notify

### prompt
source $HOME/dotfiles/zsh/prompt.zsh

### aliases
source $HOME/dotfiles/zsh/aliases.zsh

### plugins
source $HOME/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/dotfiles/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

### functions
autoload -Uz logbook

### key bindings
source $HOME/dotfiles/zsh/key_bindings.zsh

### tmux
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
  tmux attach-session -t $USER || tmux new-session -s $USER
fi

### homebrew
if [ -d /opt/homebrew ]; then
  export BREW_PREFIX="/opt/homebrew"
  export PATH="/opt/homebrew/bin:$PATH"
elif [ -d /usr/local/Homebrew ]; then
  export BREW_PREFIX="/usr/local"
  export PATH="/usr/local/bin:$PATH"
fi

### Google Cloud SDK
[[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

### rbenv
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

### asdf
[[ -f $BREW_PREFIX/opt/asdf/asdf.sh ]] && source $BREW_PREFIX/opt/asdf/asdf.sh

### kubectl completions
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

### mix
if [ -d ~/.mix ]; then
  export PATH="$HOME/.mix/escripts:$PATH"
fi

export PATH="$HOME/dotfiles/bin:$PATH"

# remove duplicates from $PATH
export PATH=$(echo -n "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')

[[ -f "$HOME/dev/elastic-cli/elastic.sh" ]] && source "$HOME/dev/elastic-cli/elastic.sh"
[[ -f "$HOME/dev/xref-tools/xref.sh" ]] && source "$HOME/dev/xref-tools/xref.sh"
