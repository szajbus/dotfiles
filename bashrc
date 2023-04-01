maybe_source () {
  [[ -f $1 ]] && source $1
}

source $HOME/dotfiles/shell/rc.sh
source $HOME/dotfiles/bash/prompt.sh

### secrets
[[ -f $HOME/.secrets ]] && source $HOME/.secrets

### direnv
maybe_source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/bashrc"
