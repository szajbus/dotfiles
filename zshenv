export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

if [[ $(uname) == "Darwin" ]]; then
  export PATH="$PATH:/opt/X11/bin:/usr/local/Cellar/smlnj/110.75/libexec/bin"
fi

export PATH="$HOME/bin:$PATH"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM=xterm-color
export PAGER=less

export EDITOR=vim
export BUNDLER_EDITOR=mvim

fpath=($HOME/dotfiles/zsh/functions $fpath)

### rbenv
if [ -d ~/.rbenv ]; then
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/shims:$PATH"
fi

# remove duplicates from $PATH
export PATH=$(echo -n "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')
