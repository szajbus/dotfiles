" Source tiny config
source ~/.vimrc.tiny

" Pathogen
if exists("pathogen#infect")
  execute pathogen#infect()
endif

" General settings
set history=1000 "Store lots of :cmdline history

" Syntax highlighting
if has("syntax")
  syntax on
endif

if has('persistent_undo')
  " Keep undo history across sessions
  silent !mkdir ~/.vim.backups > /dev/null 2>&1
  set undodir=~/.vim.backups
  set undofile
endif
