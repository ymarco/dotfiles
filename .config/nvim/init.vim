" Set compatibility to Vim only
set nocompatible

" Set TAB size to 4 spaces (instead of the default 8), but still tabs
set noet ci pi sts=0 sw=4 ts=4 smarttab
set smartindent
" Turn on syntax highlighting.
syntax on

" turn on relative line numbering
set number relativenumber

" set color scheme
colo torte

"set encoding
set encoding=utf-8

" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')

Plug 'kovetskiy/sxhkd-vim'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Navigating with guides
inoremap `<Tab> <Esc>/<++><Enter>"_c4l
vnoremap `<Tab> <Esc>/<++><Enter>"_c4l
map `<Tab> <Esc>/<++><Enter>"_c4l

" Automatically deletes all trailing whitespace on save.
" autocmd BufWritePre * %s/\s\+$//e

" Automatically update xorg when saving .Xresources
autocmd BufWritePost .Xresources !xrdb %
" SNIPPETS

"C++
autocmd FileType cpp,h inoremap ;ve <Esc>astd::vector<> <++><Esc>5hi
autocmd FileType cpp,h inoremap ;pa <Esc>astd::pair<> <++><Esc>5hi
autocmd FileType cpp,h inoremap ;st <Esc>astd::string
autocmd FileType cpp,h inoremap ;sp <Esc>astd::shared_ptr<> <++><Esc>5hi
autocmd FileType cpp,h inoremap ;um <Esc>astd::unordered_map<> <++><Esc>5hi
autocmd FileType cpp,h inoremap ;for <Esc>ifor(){<Enter><++><Enter>}<Esc>3k$hi
autocmd FileType c,cpp,h inoremap <C-e> /*  */<Esc>hhi
