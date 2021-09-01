source $HOME/dotfiles/shell/aliases.sh

maybe_source () {
  [[ -f $1 ]] && source $1
}

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
maybe_source "$HOME/google-cloud-sdk/path.zsh.inc"
maybe_source "$HOME/google-cloud-sdk/completion.zsh.inc"
maybe_source "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
maybe_source "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

### rbenv
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

### asdf
maybe_source "$BREW_PREFIX/opt/asdf/asdf.sh"
maybe_source "$HOME/.asdf/asdf.sh"

### erlang
export ERL_AFLAGS="-kernel shell_history enabled"

### mix
if [ -d ~/.mix ]; then
  export PATH="$HOME/.mix/escripts:$PATH"
fi

export PATH="$HOME/dotfiles/bin:$PATH"

# remove duplicates from $PATH
export PATH=$(echo -n "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')

# other tools
maybe_source "$HOME/dev/elastic-cli/elastic.sh"
maybe_source "$HOME/dev/xref-tools/xref.sh"
