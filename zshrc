# This file is for interactive shells.
#
# It sets options, loads shell modules, configures prompt, sets up zle and completions, and sets any
# env variables that are only used in the interactive shell.

function maybe_source () {
  [[ -f $1 ]] && source $1
}

is_busybox () {
  command -v busybox >/dev/null
}

### PATH — re-assert Homebrew precedence after macOS path_helper
# shell/env.sh (sourced from ~/.zshenv) puts Homebrew at the front of PATH, but
# /etc/zprofile then runs path_helper, which rebuilds PATH from /etc/paths and
# shoves /usr/bin ahead of Homebrew. This breaks e.g. `git` completion, which
# loads from Homebrew git but would run against the older Apple git. zshrc runs
# after path_helper, so restore the intended order here. (bash avoids this: it
# sources env.sh from ~/.bash_profile, which already runs after path_helper.)
typeset -U path PATH
if [[ -n $BREW_PREFIX ]]; then
  path=($BREW_PREFIX/bin $BREW_PREFIX/sbin $path)
  [[ -d $BREW_PREFIX/opt/curl/bin ]] && path=($BREW_PREFIX/opt/curl/bin $path)
fi

### changing directories
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

### enable extended globbing
setopt extended_glob

### functions
fpath=($HOME/dotfiles/zsh/functions $fpath)

### history
command_oriented_history=1
HISTCONTROL=ignoreboth

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=8192
export SAVEHIST=8192

setopt append_history
setopt bang_hist
setopt extended_history
setopt hist_beep
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify

### job control
setopt auto_resume
unsetopt bg_nice
unsetopt check_jobs
unsetopt hup
setopt long_list_jobs
setopt notify

### plugins
source $HOME/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/dotfiles/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

### prompt
source $HOME/dotfiles/zsh/prompt.zsh

### key bindings
source $HOME/dotfiles/zsh/key_bindings.zsh

### functions
autoload -Uz logbook

### run common commands
source $HOME/dotfiles/shell/rc.sh

### completions
if [[ -n $CODE/*/completions(#qN) ]]; then
  fpath=($CODE/*/completions $fpath)
fi

fpath=($HOME/dotfiles/zsh/completion $fpath)

if type brew &>/dev/null
then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit
compinit -i

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh-cache

setopt always_to_end
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_remove_slash
setopt complete_in_word

### kubectl completions
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

### Google Cloud SDK
maybe_source "$HOME/google-cloud-sdk/path.zsh.inc"
maybe_source "$HOME/google-cloud-sdk/completion.zsh.inc"
maybe_source "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
maybe_source "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

### secrets
[[ -f $HOME/.secrets ]] && source $HOME/.secrets

if [[ -n $HOME/.secrets.*(#qN) ]]; then
  for file in $(ls $HOME/.secrets.* 2>/dev/null); do
    source $file
  done
fi

maybe_source "$HOME/.zshrc.local"
