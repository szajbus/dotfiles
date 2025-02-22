maybe_source () {
  [[ -f $1 ]] && source $1
}

is_busybox () {
  command -v busybox >/dev/null
}

export -f maybe_source
export -f is_busybox

source $HOME/dotfiles/shell/rc.sh
source $HOME/dotfiles/bash/prompt.sh

### secrets
maybe_source $HOME/.secrets

if compgen -G $HOME/.secrets.*; then
  for file in $(ls $HOME/.secrets.* 2>/dev/null); do
    source $file
  done
fi

### completions
if ! shopt -oq posix; then
  maybe_source /usr/share/bash-completion/bash_completion
  maybe_source /etc/bash_completion
fi

for file in $HOME/dotfiles/bash/completion/*; do
  source $file
done
