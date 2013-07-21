#!/usr/bin/env zsh
# Usage:
#   install.zsh [--backup]

autoload -Uz colors
colors

for arg in $argv; do
  [[ $arg == '--backup' ]] && local backup=true
done

function install-dotfiles {
  local src="${HOME}/dotfiles/${argv[1]}"
  local dest="${HOME}/${argv[2]}"

  [[ $argv[1] == 'secrets' ]] && local secrets=true

  if $secrets; then
    [[ ! -e $dest ]] && cp $src $dest
  else
    [[ -e $dest ]] && $backup && mv $dest{,.bak}
    ln -s $src $dest
  fi

  [[ -d $src ]] && local slash='/'
  echo "+ ${fg[green]}${argv[1]}${slash}${reset_color}"
}

function execute-script {
  local script="${HOME}/dotfiles/install/${argv[1]}"
  `${script} > /dev/null 2>&1`
  echo "+ ${fg[green]}${argv[1]}${reset_color}"
}

function group-dotfiles {
  echo "[${fg[magenta]}${argv[1]}${reset_color}]"
}

group-dotfiles zsh
install-dotfiles zsh .zsh
install-dotfiles zshenv .zshenv
install-dotfiles zshrc .zshrc
install-dotfiles secrets .secrets

group-dotfiles git
install-dotfiles gitconfig .gitconfig
install-dotfiles gitignore .gitignore

group-dotfiles ruby
install-dotfiles gemrc .gemrc
install-dotfiles irbrc .irbrc
install-dotfiles powconfig .powconfig
install-dotfiles pryrc .pryrc

group-dotfiles input
install-dotfiles inputrc .inputrc

if [[ $(uname) == "Darwin" ]]; then
  group-dotfiles osx
  execute-script osx-defaults
  execute-script spotlight-reindex
else;
  group-dotfiles linux
  install-dotfiles hushlogin .hushlogin
fi
