export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM=xterm-color
export PAGER=less

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

export CODE="$HOME/code"

export EDITOR=vim
export GIT_EDITOR="vim -u ~/.vimrc.tiny"
export MARKDOWN_EDITOR="$EDITOR"

if [ "$SSH_CONNECTION" = "" ]; then
  export VISUAL=cursor
  export BUNDLER_EDITOR="$VISUAL"
fi

### homebrew
if [ -d /opt/homebrew ]; then
  export BREW_PREFIX="/opt/homebrew"
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
elif [ -d /usr/local/Homebrew ]; then
  export BREW_PREFIX="/usr/local"
  export PATH="/usr/local/bin:$PATH"
fi

if [ -d $BREW_PREFIX/opt/curl ]; then
  export PATH="$BREW_PREFIX/opt/curl/bin:$PATH"
fi

if [[ -n $BREW_PREFIX ]]; then
  export CPATH="$CPATH:$BREW_PREFIX/include"
  export LIBRARY_PATH="$LIBRARY_PATH:$BREW_PREFIX/lib"
fi

if [[ $(uname) == "Darwin" ]]; then
  # the following function succeeds only when dark mode is enabled
  defaults read -g AppleInterfaceStyle >/dev/null 2>&1 && export DARK_MODE=1

  # prevent python crashes on macOS 10.13+, e.g. when using hvac via ansible
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi

export KEYTIMEOUT=1

if command -v tty >/dev/null; then
  export GPG_TTY=$(tty)
fi

### shims
for shim in $(ls $HOME/dotfiles/shims); do
  which $shim > /dev/null && eval "export NOSHIM_${shim}=$(which $shim)"
done

### custom
export ES="http://localhost:9200"
export JSON="-Hcontent-type:application/json"

export REGEX_IP='[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}'
