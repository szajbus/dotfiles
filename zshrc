### changing directories
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

### functions
fpath=($HOME/dotfiles/zsh/functions $fpath)

### completion
fpath=($HOME/dotfiles/zsh/completion $HOME/dev/*/completions $fpath)
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
setopt extended_glob

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

### prompt
source $HOME/dotfiles/zsh/prompt.zsh

### plugins
source $HOME/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/dotfiles/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

### functions
autoload -Uz logbook

### kubectl completions
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

### run common commands
source $HOME/dotfiles/shell/rc.sh

### secrets
[[ -f $HOME/.secrets ]] && source $HOME/.secrets
