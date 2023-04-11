source $HOME/dotfiles/shell/aliases.sh

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
export PATH="$HOME/dotfiles/shims:$PATH"

# remove duplicates from $PATH
export PATH=$(echo -n "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')
export CPATH=$(echo -n "$CPATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')
export LIBRARY_PATH=$(echo -n "$LIBRARY_PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')

# other tools
maybe_source "$CODE/elastic-cli/elastic.sh"
maybe_source "$CODE/xref-tools/xref.sh"
