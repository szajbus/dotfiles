source $HOME/dotfiles/shell/aliases.sh

### tmux
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
  tmux attach-session -t $USER || tmux new-session -s $USER
fi

### rbenv
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

### asdf
maybe_source "$BREW_PREFIX/opt/asdf/libexec/asdf.sh"
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
export CPATH=$(echo -n "$CPATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')
export LIBRARY_PATH=$(echo -n "$LIBRARY_PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')

# other tools
maybe_source "$CODE/elastic-cli/elastic.sh"
maybe_source "$CODE/xref-tools/xref.sh"
