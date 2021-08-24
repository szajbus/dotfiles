source $HOME/dotfiles/shell/aliases.sh

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
if [ -f $BREW_PREFIX/opt/asdf/asdf.sh ]; then
  source $BREW_PREFIX/opt/asdf/asdf.sh
elif [ -f $HOME/.asdf/asdf.sh ]; then
  source $HOME/.asdf/asdf.sh
fi

### erlang
export ERL_AFLAGS="-kernel shell_history enabled"

### mix
if [ -d ~/.mix ]; then
  export PATH="$HOME/.mix/escripts:$PATH"
fi

export PATH="$HOME/dotfiles/bin:$PATH"

# remove duplicates from $PATH
export PATH=$(echo -n "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')

[[ -f "$HOME/dev/elastic-cli/elastic.sh" ]] && source "$HOME/dev/elastic-cli/elastic.sh"
[[ -f "$HOME/dev/xref-tools/xref.sh" ]] && source "$HOME/dev/xref-tools/xref.sh"
