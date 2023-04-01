source $HOME/dotfiles/shell/aliases.sh

maybe_source () {
  [[ -f $1 ]] && source $1
}

maybe_add_to_path () {
  [[ -f $1 ]] && export PATH="$1:$PATH"
}

### tmux
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
  tmux attach-session -t $USER || tmux new-session -s $USER
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
maybe_add_to_path "$BREW_PREFIX/opt/asdf/bin"
maybe_add_to_path "$HOME/.asdf/bin"

### erlang
export ERL_AFLAGS="-kernel shell_history enabled"

### mix
if [ -d ~/.mix ]; then
  export PATH="$HOME/.mix/escripts:$PATH"
fi

export PATH="$HOME/dotfiles/bin:$PATH"

# remove duplicates from $PATH
export PATH=$(echo -n "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')
export CPATH=$(echo -n "$CPATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')
export LIBRARY_PATH=$(echo -n "$LIBRARY_PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')

# other tools
maybe_source "$CODE/elastic-cli/elastic.sh"
maybe_source "$CODE/xref-tools/xref.sh"
