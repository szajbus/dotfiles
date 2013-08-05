" Change leader to a comma
let mapleader=","

" Move between split windows by using H, J, K, L
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" Use Cmd+Number to go to specific tab
map <silent> <D-1> :tabn 1<cr>
map <silent> <D-2> :tabn 2<cr>
map <silent> <D-3> :tabn 3<cr>
map <silent> <D-4> :tabn 4<cr>
map <silent> <D-5> :tabn 5<cr>
map <silent> <D-6> :tabn 6<cr>
map <silent> <D-7> :tabn 7<cr>
map <silent> <D-8> :tabn 8<cr>
map <silent> <D-9> :tabn 9<cr>

" Open nerd tree with Cmd-N
nmap <D-N> :NERDTreeToggle<CR>

" Open the project tree and expose current file with Ctrl-\
nnoremap <silent> <C-\> :NERDTreeFind<CR>:vertical res 30<CR>

" Toggle comments with Cmd+/
map <D-/> :TComment<CR>
imap <D-/> <Esc>:TComment<CR>

