set nocompatible
filetype off
set encoding=utf-8

set shell=bash

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'vim-scripts/comments.vim'
Bundle 'vim-scripts/restore_view.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'

" Use mouse pointer
set mouse=a

" Use single <Leader> for easymotion
map <Leader> <Plug>(easymotion-prefix)

" easymotion matches uppercase using lowercase
let g:EasyMotion_smartcase = 1

" 256 colour ability is not reported properly
set t_Co=256

colorscheme distinguished

syntax on
filetype plugin indent on

" Start NERDTree if no file was specified
autocmd vimenter * if !argc() | NERDTree | endif

" Easy window switching
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Esay window switching for tablet via SSH
nmap <silent> <F5> :wincmd h<CR>
nmap <silent> <F6> :wincmd j<CR>
nmap <silent> <F7> :wincmd k<CR>
nmap <silent> <F8> :wincmd l<CR>

" Set tab width to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Don't break Python indentation
au FileType python set noexpandtab

" Set options to restore from last session
set viewoptions=cursor,folds,slash,unix

" Set indent folding with manual override
set foldmethod=indent

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

" Find using CtrlP
command Find :CtrlP

" I have a habit of not releasing shift fast enough
command W :w
command Q :q
command Qa :qa

let g:NERDTreeMouseMode=2   " Single click for folding directories
let g:NERDTreeChDirMode=2   " Change working dir to NERDTree dir
let g:NERDTreeMinimalUI=1   " Use minimal UI
if has("win32unix")         " When using Cygwin
  let g:NERDTreeDirArrows=0 " Use simple directory arrows
else
  let g:NERDTreeDirArrows=1 " Otherwise use nice arrows
endif

" Set C syntax highlighting for Arduino source files
autocmd BufWinEnter *.ino set filetype=c

" Add :Render command for SCAD files
autocmd BufWinEnter *.scad command Render execute "!openscad % &"
