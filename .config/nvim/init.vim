set nocompatible
syntax on

" Set TAB size to 4 spaces (instead of the default 8), but still tabs
set noet ci pi sts=0 sw=4 ts=4 smarttab
set smartindent

" turn on relative line numbering
set number relativenumber

" set color scheme
"colo torte

"set encoding
set encoding=utf-8

" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
" language specific
Plug 'kovetskiy/sxhkd-vim',      { 'for':'sxhkdrc'}                         " sxhkd colors
Plug 'NLKNguyen/c-syntax.vim',   { 'for': ['c','cpp','cuda']}               " better c syntax highlighting
Plug 'plasticboy/vim-markdown',  { 'for':'markdown'}                        " better markdown syntax highlighting (unsused)
Plug 'elzr/vim-json',            { 'for':'json'}                            " better json syntax highlighting
Plug 'vim-python/python-syntax', { 'for':'python'}                          " better python syntax highlighting
Plug 'fatih/vim-go',             { 'do': ':GoInstallBinaries', 'for':'go' } " VIM GO

" util
Plug 'vim-airline/vim-airline'        " vim statusbar theme
Plug 'vim-airline/vim-airline-themes' " vim statusbar theme theme
Plug 'SirVer/ultisnips'               " snippets
Plug 'godlygeek/tabular'              " align text
Plug 'NLKNguyen/papercolor-theme'     " theme
Plug 'jiangmiao/auto-pairs'           " auto closing braces
call plug#end()

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

" auto-pairs settings
let g:AutoPairsFlyMode = 1
" ASTHETICS
colorscheme PaperColor
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'
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
