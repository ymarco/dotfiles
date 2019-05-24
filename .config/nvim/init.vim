set nocompatible
syntax on

" Set TAB size to 4 spaces (instead of the default 8), but still tabs
set noet ci pi sts=0 sw=4 ts=4 smarttab
set smartindent

" turn on relative line numbering
set number relativenumber

" set color scheme
"colo desert

"set encoding
set encoding=utf-8

" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
" language specific
Plug 'kovetskiy/sxhkd-vim',      { 'for':'sxhkdrc'}                         " syntax highlighting (sxhkd)
Plug 'NLKNguyen/c-syntax.vim',   { 'for': ['c','cpp','cuda']}               " syntax highlighting (c family)
Plug 'plasticboy/vim-markdown',  { 'for':'markdown'}                        " syntax highlighting (markdown) (unused)
Plug 'elzr/vim-json',            { 'for':'json'}                            " syntax highlighting (json)
Plug 'vim-python/python-syntax', { 'for':'python'}                          " syntax highlighting (python)
Plug 'fatih/vim-go',             { 'do': ':GoInstallBinaries', 'for':'go' } " VIM-GO
Plug 'tbastos/vim-lua', 		 { 'for': 'lua'}                            " syntax highlighting (lua)

" util
Plug 'SirVer/ultisnips'               " snippets
Plug 'godlygeek/tabular'              " align text
Plug 'NLKNguyen/papercolor-theme'     " theme
Plug 'jiangmiao/auto-pairs'           " auto closing braces
call plug#end()

set t_Co=16
" Snippets
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetDir='/home/yoavm448/.config/nvim/UltiSnipsSnippets'
let g:UltiSnipsSnippetDirectories = ['/home/yoavm448/.config/nvim/UltiSnipsSnippets', 'UltiSnips']
" set runtimepath+=/home/yoavm448/.config/nvim/UltiSnipsSnippets

" vim-go settings
let g:go_highlight_types          = 1
let g:go_highlight_functions      = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators      = 1

" vim-python settings
let g:python_highlight_all = 1

" ASTHETICS
colorscheme PaperColor
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }

" Y now works like C and D
nnoremap Y y$

" ctrl+q is J
noremap Q J
" Shortcutting split navigation, saving a keypress:
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set splitbelow
set splitright

" J and K are amplified j and k
nnoremap J 5j
nnoremap K 5k
vnoremap J 5j
vnoremap K 5k

" Control + {h,j,k,l} are replacement for arrow keys
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" Navigating with guides
inoremap `<Tab> <Esc>/<++><Enter>"_c4l
vnoremap `<Tab> <Esc>/<++><Enter>"_c4l
map `<Tab> <Esc>/<++><Enter>"_c4l

nnoremap <Tab> :bnext<Enter>

" Automatically deletes all trailing whitespace on save.
" autocmd BufWritePre * %s/\s\+$//e

" Automatically update xorg when saving .Xresources
autocmd BufWritePost .Xresources !xrdb %
