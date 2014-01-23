set nocompatible
set encoding=utf-8

" Use mouse pointer
set mouse=a

" 256 colour ability is not reported properly
set t_Co=256

colorscheme distinguished

execute pathogen#infect()
syntax on
filetype plugin indent on

" Start NERDTree if no file was specified
autocmd vimenter * if !argc() | NERDTree | endif

" Set tab width to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Set options to restore from last session
set viewoptions=cursor,folds,slash,unix

" Set indent folding with manual override
set foldmethod=indent
nnoremap <F2> :set foldmethod=manual <CR>

" Don't use swap and backup files
set noswapfile
set nobackup
set nowritebackup

" Auto read changes
set autoread

" Don't wrap on new line
set nowrap
set nolbr

" Show folds and line numbers on left, add highlights
set foldcolumn=2
set cursorline
set number

" Single click for folding directories
let NERDTreeMouseMode=2

" Set C syntax highlighting for Arduino source files
autocmd BufWinEnter *.ino set filetype=c
