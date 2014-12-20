set nocompatible
filetype off
set encoding=utf-8

set shell=bash

let g:vundle_default_git_proto='git'
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'restore_view.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
Bundle 'l9'
Bundle 'FuzzyFinder'
Bundle 'kien/ctrlp.vim'
Bundle 'Licenses'
Bundle 'Rip-Rip/clang_complete'
Bundle 'ervandew/supertab'
Bundle 'jnwhiteh/vim-golang'
Bundle 'wikitopian/hardmode'
Bundle 'openscad.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-airline'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'vasconcelloslf/vim-interestingwords'
Bundle 'tpope/vim-abolish'
Bundle 'kana/vim-operator-user'
Bundle 'rhysd/vim-clang-format'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-eunuch'

" Use Space as Leader
let mapleader = " "


""""""""""""""""""
" GENERAL CONFIG "
""""""""""""""""""

" Use mouse (really just do this for the sake of having a sensible scroll wheel)
set mouse=a

" Airline config
let g:airline_theme = 'bubblegum'

set laststatus=2
set timeoutlen=250

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

let g:syntastic_python_checkers = ['pep8', 'pylint']
let g:syntastic_python_pylint_args = "--disable=W0312,C0111,C0301"
let g:syntastic_python_pep8_args = "--ignore=E501"

let g:syntastic_cppcheckers = ['gcc', 'clang']

" Clang Format config
let g:clang_format#command = 'clang-format-3.5'
let g:clang_format#detect_style_file = 1

" easymotion matches uppercase using lowercase
let g:EasyMotion_smartcase = 1

" 256 colour ability is not reported properly
set t_Co=256

colorscheme distinguished

syntax on
filetype plugin indent on

" Set tab width to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Complete options (disable preview scratch window, limit popup items)
set completeopt=menu,menuone,longest
set pumheight=15

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

" LaTeX config
let g:Tex_DefaultTargetFormat='pdf'
set shellslash
set grepprg=grep\ -nH\ $*

" Manual spelling command
command Spell setlocal spell spelllang=en_us
command SpellOff setlocal spell spelllang=


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
" 80 CHAR WIDTH WARN "
""""""""""""""""""""""

highlight CharLim ctermbg=130 guibg=#592929
highlight link CharLimMatch NONE
match CharLimMatch /\%81v.\+/

let s:showOverLength = 0

function ToggleShowOverLength()
  if s:showOverLength
    hi link CharLimMatch NONE
    let s:showOverLength = 0
  else
    hi link CharLimMatch CharLim
    let s:showOverLength = 1
  endif
endfun


""""""""""""""""
" KEY MAPPINGS "
""""""""""""""""

" Command to open my to-do Gist for work
command MantidTodo :Gist 6160cf8e8c55749b7fb7

" Handy shortcut for replacing words
map <Leader>r :%s/\<<C-r><C-w>\>/

" 80 char limit warning
map <Leader>8 :call ToggleShowOverLength()<CR>

" Git tools
map <Leader>gd :Gvdiff<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gs :Gstatus<CR>

" Syntax checking
map <F6> :SyntasticCheck<CR>
map <Leader>sc :SyntasticCheck<CR>
map <Leader>sr :SyntasticReset<CR>

" Manual spelling toggle
map <Leader>ss :Spell<CR>
map <Leader>s :SpellOff<CR>

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

" Toggle NERDTree on Leader-n
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

" I have a habit of not releasing shift fast enough
command W :w
command Q :q
command Qa :qa

" Highlight shortcuts
nnoremap <silent> <leader>h :call InterestingWords()<cr>
nnoremap <silent> <leader>H :call UncolorAllWords()<cr>


"""""""""""""""""""""""""""
" SYSTEM DEPENDANT CONFIG "
"""""""""""""""""""""""""""

let hostname = substitute(system('hostname'), '\n', '', '')

" Use Powerline fonts if not on Windows
if !has("win32unix")
  let g:airline_powerline_fonts = 1
endif

" An SSH only machine, cannot guarentee I will have Powerline fonts
if hostname == "ritchie"
  call SSHMode()
endif

" Another SSH only machine, same assumption
if hostname == "yukari"
  call SSHMode()
endif
