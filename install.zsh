#!/usr/bin/env zsh
# Usage:
#   install.zsh

autoload -Uz colors
colors

function ask {
  local answer=false

  echo -n "  ${fg[yellow]}${argv[1]} (y/N): ${reset_color}"
  read -sq && local answer=true
  $answer && echo yes || echo no
  $answer && return 0
}

function install-dotfiles {
  local src="${HOME}/dotfiles/${argv[1]}"
  local dest="${HOME}/${argv[2]}"
  local secrets=false

  [[ $argv[1] == 'secrets' ]] && local secrets=true

  if $secrets; then
    [[ ! -e $dest ]] && cp $src $dest
  else
    [[ ! -L $dest ]] && $backup && mv -f $dest{,.bak}
    ln -nfs $src $dest
  fi

  [[ -d $src ]] && local slash='/'
  echo "+ ${fg[green]}${argv[1]}${slash}${reset_color}"
}

function execute-script {
  local script="${HOME}/dotfiles/install/${argv[1]}"
  `${script} > /dev/null 2>&1`
  echo "+ ${fg[green]}${argv[1]}${reset_color}"
}

function ask-execute-script {
  ask "install ${argv[1]}?" && execute-script $argv[1]
}

function group-dotfiles {
  echo "[${fg[magenta]}${argv[1]}${reset_color}]"
}

function copy-files {
  cp -f ${HOME}/dotfiles/${argv[1]}/* ${argv[2]}
  echo "+ ${fg[green]}${argv[1]}${reset_color}"
}

local backup=false
ask "backup files?" && backup=true

group-dotfiles dotfiles
execute-script update-submodules

group-dotfiles zsh
install-dotfiles zsh .zsh
install-dotfiles zshenv .zshenv
install-dotfiles zshrc .zshrc
install-dotfiles secrets .secrets

group-dotfiles git
install-dotfiles gitconfig .gitconfig
install-dotfiles gitignore .gitignore

group-dotfiles ruby
install-dotfiles aprc .aprc
install-dotfiles gemrc .gemrc
install-dotfiles irbrc .irbrc
install-dotfiles powconfig .powconfig
install-dotfiles pryrc .pryrc

group-dotfiles input
install-dotfiles inputrc .inputrc

group-dotfiles ack
install-dotfiles ackrc .ackrc

group-dotfiles vim
install-dotfiles vim .vim
install-dotfiles vimrc .vimrc
ask-execute-script build-vim-plugins

if [[ $(uname) == "Darwin" ]]; then
  group-dotfiles osx
  ask-execute-script osx-defaults
  ask-execute-script spotlight-reindex
  copy-files fonts ~/Library/fonts
else;
  group-dotfiles linux
  install-dotfiles hushlogin .hushlogin
fi
