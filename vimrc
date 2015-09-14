set nocompatible
filetype off
set encoding=utf-8

set shell=bash


"""""""""""""""""
" VUNDLE CONFIG "
"""""""""""""""""

let g:vundle_default_git_proto='git'
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'restore_view.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'l9'
Plugin 'FuzzyFinder'
Plugin 'kien/ctrlp.vim'
Plugin 'Licenses'
" Plugin 'Rip-Rip/clang_complete'
Plugin 'ervandew/supertab'
Plugin 'jnwhiteh/vim-golang'
Plugin 'wikitopian/hardmode'
Plugin 'openscad.vim'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'vasconcelloslf/vim-interestingwords'
Plugin 'tpope/vim-abolish'
Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'lervag/vim-latex'
Plugin 'vim-compile'
" Plugin 'dbeniamine/todo.txt-vim'
Plugin 'freitass/todo.txt-vim'
Plugin 'tclem/vim-arduino'
Plugin 'reedes/vim-lexical'


""""""""""""""""""
" GENERAL CONFIG "
""""""""""""""""""

" Use Space as Leader
let mapleader = " "

" Use mouse (really just do this for the sake of having a sensible scroll wheel)
set mouse=a

" Airline config
let g:airline_theme = 'bubblegum'

set laststatus=2
set timeoutlen=250

set wildignore+=*~,*.pyc,*.so,*.o

" Tagbar config
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

" Syntastic config
let g:syntastic_mode_map = { 'mode': 'passive',
                          \ 'active_filetypes': [],
                          \ 'passive_filetypes': [] }
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

let g:syntastic_java_checkers = []

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_args = "--rcfile=~/.pylintrc"

let g:syntastic_cppcheckers = ['gcc', 'clang']

" Clang Format config
let g:clang_format#command = 'clang-format-3.5'
let g:clang_format#detect_style_file = 1

" Spelling config
let g:lexical#spell_key = '<leader>ss'
let g:lexical#thesaurus_key = '<leader>st'
let g:lexical#spelllang = ['en_gb']
command Spell call lexical#init({'spell': 1})
command SpellOff call lexical#init({'spell': 0})

" easymotion matches uppercase using lowercase
let g:EasyMotion_smartcase = 1

" 256 colour ability is not reported properly
set t_Co=256

colorscheme distinguished

syntax on
filetype plugin indent on

set colorcolumn=80

" Set tab width to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Complete options (disable preview scratch window, limit popup items)
set completeopt=menu,menuone,longest
set pumheight=15

let g:interestingWordsRandomiseColors = 1

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

" Clang should not autocomplete
let g:clang_complete_auto = 0

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

" Squelch bells
set noerrorbells
set novisualbell

" Vim search config
set incsearch
set hlsearch

" Show folds and line numbers on left, add highlights
set foldcolumn=2
set cursorline
set number
if exists('+relativenumber')
  set relativenumber
endif

" NERDTree config
let g:NERDTreeMouseMode=2   " Single click for folding directories
let g:NERDTreeChDirMode=2   " Change working dir to NERDTree dir
let g:NERDTreeMinimalUI=1   " Use minimal UI
let g:NERDTreeIgnore=['.pyc']


"""""""""""""""""""""""""""""""
" MISC COMMANDS AND FUNCTIONS "
"""""""""""""""""""""""""""""""

" Remove trailing whitespace
command! RemTrailWhilespace :%s/\s\+$//

function SSHMode()
  let g:airline_powerline_fonts = 0
  let g:NERDTreeDirArrows = 0
endfunction

command! SSH :call SSHMode()


""""""""""""""""""""""
" WHITESPACE WARNING "
""""""""""""""""""""""

highlight TrailingWhitespace ctermbg=130 guibg=#592929
match TrailingWhitespace /\s\+\%#\@<!$/


""""""""""""""""
" KEY MAPPINGS "
""""""""""""""""

" Handy shortcut for replacing words
map <Leader>r :%s/\<<C-r><C-w>\>/

" Git tools
map <Leader>gd :Gvdiff<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gs :Gstatus<CR>

" Syntax checking
map <F6> :SyntasticCheck<CR>
map <Leader>c :SyntasticCheck<CR>
map <Leader>C :SyntasticReset<CR>

" Manual spelling toggle
map <Leader>s :Spell<CR>
map <Leader>S :SpellOff<CR>

" Highlight shortcuts
nnoremap <silent> <leader>h :call InterestingWords('n')<cr>
nnoremap <silent> <leader>H :call UncolorAllWords()<cr>

" Find shortcuts
map <Leader>l :FufLine<CR>
map <Leader>f :CtrlP<CR>
map <Leader>b :CtrlPBuffer<CR>

" Toggle folding
map <Leader>z zA
map <Leader>a zR

" Commenting
map <C-X> gcc
vmap <C-X> gc

" Toggle NERDTree
map <Leader>n :NERDTreeToggle<CR>

" Toggle tagbar
map <Leader>t :TagbarToggle<CR>

" Tab shortcuts
nmap <Leader>t<Left> :tabp<CR>
nmap <Leader>t<Right> :tabn<CR>
nmap <Leader>tt :tab new<CR>

" Easy window switching
nmap <Leader>wk :wincmd k<CR>
nmap <Leader>wj :wincmd j<CR>
nmap <Leader>wh :wincmd h<CR>
nmap <Leader>wl :wincmd l<CR>

" Easy indent/unindent
map <Leader>, <<
map <Leader>. >>
vmap < <gv
vmap > >gv

" Fast saving and exiting
nmap <Leader>w :w<CR>
nmap <Leader>x :x<CR>
nmap <Leader>q :q<CR>

" I have a habit of not releasing shift fast enough
command W :w
command Q :q
command Qa :qa


"""""""""""""""""""""""""""
" SYSTEM DEPENDANT CONFIG "
"""""""""""""""""""""""""""

let hostname = substitute(system('hostname'), '\n', '', '')

" Use Powerline fonts if not on Windows
if !has("win32unix")
  let g:airline_powerline_fonts = 1
else
  call SSHMode()
endif

" An SSH only machine, cannot guarentee I will have Powerline fonts
if hostname == "borg.ncl.ac.uk"
  call SSHMode()
endif
