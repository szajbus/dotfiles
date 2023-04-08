#!/bin/bash
# Install dotfiles on remote host
#
# Usage:
#   sync.sh <host> <profile>

REMOTE=$1
PROFILE=$2
PROFILE_PATH=~/dotfiles/remotes/${PROFILE}.profile

if [ ! -f $PROFILE_PATH ]; then
  echo "no profile found at ${PROFILE_PATH}"
  exit 1
fi

source $PROFILE_PATH

tar -c --directory ~/dotfiles ${DOTFILES_PATTERN[@]} \
  | ssh \
    -o PermitLocalCommand=no \
    -o RemoteCommand=none \
    -o RequestTTY=no \
    $REMOTE "
      cat > dotfiles.${PROFILE}.tar;
      mkdir ~/dotfiles 2> /dev/null;
      tar -mx --directory ~/dotfiles -f dotfiles.${PROFILE}.tar;
      for src in \$(find ~/dotfiles -maxdepth 1 -not -type d); do
        dest=.\${src##*/}
        [ -f \${dest} ] && [ ! -L \${dest} ] && cp \${dest} \${dest}.bak
        ln -nfs \${src} \${dest}
      done;
      rm dotfiles.${PROFILE}.tar"
