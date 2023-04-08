maybe_source () {
  [[ -f $1 ]] && source $1
}

export -f maybe_source

source $HOME/dotfiles/shell/rc.sh
source $HOME/dotfiles/bash/prompt.sh

### secrets
[[ -f $HOME/.secrets ]] && source $HOME/.secrets

### completions
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
