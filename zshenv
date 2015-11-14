export PATH="/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"

if [[ $(uname) == "Darwin" ]]; then
  export PATH="$PATH:/opt/X11/bin:/usr/local/Cellar/smlnj/110.75/libexec/bin"
  export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools:$HOME/Library/Android/sdk/tools"
fi

export PATH="$HOME/bin:$PATH"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM=xterm-color
export PAGER=less

export EDITOR=vim
export VISUAL=atom
export BUNDLER_EDITOR="$VISUAL"

fpath=($HOME/dotfiles/zsh/functions $fpath)

### rbenv
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# remove duplicates from $PATH
export PATH=$(echo -n "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')
