set nocompatible
filetype off
set encoding=utf-8

set shell=bash

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'comments.vim'
Bundle 'restore_view.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
Bundle 'l9'
Bundle 'FuzzyFinder'
Bundle 'taglist.vim'
Bundle 'Licenses'

" Use mouse pointer
set mouse=a

" Use single <Leader> for easymotion
map <Leader> <Plug>(easymotion-prefix)

" PyLint config
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_args = "--disable=W0312,C0111,C0301"

" easymotion matches uppercase using lowercase
let g:EasyMotion_smartcase = 1

" 256 colour ability is not reported properly
set t_Co=256

colorscheme distinguished

syntax on
filetype plugin indent on

" Start NERDTree if no file was specified
autocmd vimenter * if !argc() | NERDTree | endif

" Toggle NERDTree on Leader-n
map <Leader>n :NERDTreeToggle<CR>

" Find shortcuts
map <silent> <Leader>f :FufLine<CR>
nmap <silent> <Leader>o :FufFile<CR>

" Toggle taglist
map <silent> <Leader>tt :TlistToggle<CR>

" Open new tab on Leader-t
map <Leader>t :tabnew<CR>

" Easy tab switching
nmap <silent> <Leader>t<Left> :tabp<CR>
nmap <silent> <Leader>t<Right> :tabn<CR>

" Easy window switching
nmap <silent> <Leader>w<Up> :wincmd k<CR>
nmap <silent> <Leader>w<Down> :wincmd j<CR>
nmap <silent> <Leader>w<Left> :wincmd h<CR>
nmap <silent> <Leader>w<Right> :wincmd l<CR>

" I have a habit of not releasing shift fast enough
command W :w
command Q :q
command Qa :qa

" Set tab width to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

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

" Don't overcrowd taglist
let g:Tlist_Show_One_File=1

let g:NERDTreeMouseMode=2   " Single click for folding directories
let g:NERDTreeChDirMode=2   " Change working dir to NERDTree dir
let g:NERDTreeMinimalUI=1   " Use minimal UI
if has("win32unix")         " When using Cygwin
  let g:NERDTreeDirArrows=0 " Use simple directory arrows
else
  let g:NERDTreeDirArrows=1 " Otherwise use nice arrows
endif

" LaTeX config
let g:Tex_DefaultTargetFormat='pdf'
set shellslash
set grepprg=grep\ -nH\ $*

" Manual spelling command
command Spell setlocal spell spelllang=en_us
command SpellOff setlocal spell spelllang=
