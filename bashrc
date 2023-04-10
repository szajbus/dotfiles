maybe_source () {
  [[ -f $1 ]] && source $1
}

export -f maybe_source

source $HOME/dotfiles/shell/rc.sh
source $HOME/dotfiles/bash/prompt.sh

### secrets
maybe_source $HOME/.secrets

### completions
if ! shopt -oq posix; then
  maybe_source /usr/share/bash-completion/bash_completion
  maybe_source /etc/bash_completion
fi

for file in $HOME/dotfiles/bash/completion/*; do
  source $file
done
