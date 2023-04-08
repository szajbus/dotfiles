maybe_source () {
  [[ -f $1 ]] && source $1
}

export -f maybe_source

source $HOME/dotfiles/shell/rc.sh
source $HOME/dotfiles/bash/prompt.sh

### secrets
[[ -f $HOME/.secrets ]] && source $HOME/.secrets
