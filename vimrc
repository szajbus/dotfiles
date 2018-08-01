" Source tiny config
source ~/.vimrc.tiny

" Pathogen
execute pathogen#infect()

" General settings
set history=1000 "Store lots of :cmdline history

" Syntax highlighting
syntax on

if has('persistent_undo')
  " Keep undo history across sessions
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif
