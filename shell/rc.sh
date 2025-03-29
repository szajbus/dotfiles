source $HOME/dotfiles/shell/aliases.sh

### asdf
export PATH="$HOME/.asdf/shims:$PATH"

### erlang
export ERL_AFLAGS="-kernel shell_history enabled"

### mix
if [ -d ~/.mix ]; then
  export PATH="$HOME/.mix/escripts:$PATH"
fi

### local
if [[ -d ~/.local/bin ]]; then
  export PATH="~/.local/bin:$PATH"
fi

### golang
WHERE_GOLANG=$(asdf where golang 2> /dev/null)
if [[ $? -eq 0 && -n "$WHERE_GOLANG" ]]; then
  export GOPATH="$WHERE_GOLANG/packages"
  export GOROOT="$WHERE_GOLANG/go"
  export PATH="$(go env GOPATH)/bin:$PATH"
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
