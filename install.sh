#!/bin/bash
# Usage:
#   install.sh

backup=false

function ask {
  read -p "  $1 (y/N) " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] && return 0
}

function install-dotfiles {
  local src="${HOME}/dotfiles/$1"
  local dest="${HOME}/$2"
  local secrets=false

  [[ $1 == 'secrets' ]] && local secrets=true

  if $secrets; then
    [[ ! -e $dest ]] && cp $src $dest
  else
    [[ ! -L $dest ]] && $backup && mv -f $dest{,.bak}
    ln -nfs $src $dest
  fi

  [[ -d $src ]] && local slash='/'
  echo "+ $1${slash}"
}

function execute-script {
  local script="${HOME}/dotfiles/install/$1"
  `${script} > /dev/null 2>&1`
  echo "+ $1"
}

function ask-execute-script {
  ask "install $1?" && execute-script $1
}

function group {
  echo "[$1]"
}

function copy-files {
  cp -f ${HOME}/dotfiles/$1/* $2
  echo "+ $1"
}

ask "backup files?" && backup=true

group dotfiles
execute-script update-submodules

group bash
install-dotfiles bash_profile .bash_profile
install-dotfiles bashrc .bashrc

group zsh
install-dotfiles zsh .zsh
install-dotfiles zshenv .zshenv
install-dotfiles zshrc .zshrc
install-dotfiles secrets .secrets

group git
install-dotfiles gitconfig .gitconfig
install-dotfiles gitignore .gitignore

group ruby
install-dotfiles aprc .aprc
install-dotfiles gemrc .gemrc
install-dotfiles irbrc .irbrc
install-dotfiles pryrc .pryrc

group input
install-dotfiles inputrc .inputrc

group ack
install-dotfiles ackrc .ackrc

group curl
install-dotfiles curlrc .curlrc

group tmux
execute-script install-tmux-plugins
install-dotfiles tmux.conf .tmux.conf

group vim
install-dotfiles vim .vim
install-dotfiles vimrc .vimrc
install-dotfiles vimrc.tiny .vimrc.tiny

if [[ $(uname) == "Darwin" ]]; then
  group osx
  ask-execute-script homebrew
  ask-execute-script osx-defaults
  ask-execute-script spotlight-reindex
  copy-files fonts ~/Library/fonts
else
  group linux
  install-dotfiles hushlogin .hushlogin
fi
