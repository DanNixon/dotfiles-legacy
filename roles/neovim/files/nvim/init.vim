set nocompatible
set encoding=utf-8

filetype off

"""""""""""""""""
" PLUGIN CONFIG "
"""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'chrisbra/csv.vim'
Plug 'chriskempson/base16-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/restore_view.vim'
Plug 'scrooloose/syntastic'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'freitass/todo.txt-vim'
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'reedes/vim-lexical'
Plug 'kana/vim-operator-user'
Plug 'sirtaj/vim-openscad'
Plug 'sheerun/vim-polyglot'
Plug 'Konfekt/vim-sentencewrap'
Plug 'tpope/vim-surround'
Plug 'VundleVim/Vundle.vim'

call plug#end()

""""""""""""""""""
" GENERAL CONFIG "
""""""""""""""""""

filetype plugin indent on
syntax on

" Use Space as Leader
let mapleader = " "

set wildignore+=*~,*.pyc,*.so,*.o

" Tagbar config
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

" Syntastic config
let g:syntastic_mode_map = { 'mode': 'passive',
                          \ 'active_filetypes': [],
                          \ 'passive_filetypes': [] }
let g:syntastic_auto_loc_list = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_cppcheckers = ['gcc', 'clang']
let g:syntastic_python_checkers = ['flake8', 'pylint']

" Clang Format config
let g:clang_format#command = 'clang-format'
let g:clang_format#detect_style_file = 1

" Spelling config
let g:lexical#spell_key = '<leader>ss'
let g:lexical#thesaurus_key = '<leader>st'
let g:lexical#spelllang = ['en_gb']
command Spell call lexical#init({'spell': 1})
command SpellOff call lexical#init({'spell': 0})

" Terminal colour
let base16colorspace = 256
colorscheme base16-default-dark

" Terminal title
set title

" Airline config
let g:airline_powerline_fonts = 1

set laststatus=2
set timeoutlen=500

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
set viewoptions=cursor,slash,unix

" Don't use swap and backup files
set noswapfile
set nobackup
set nowritebackup

" Don't wrap on new line
set nowrap
set nolbr

" Squelch bells
set noerrorbells
set novisualbell

" Vim search config
set incsearch
set hlsearch

" Show relative line numbers on left
set number
set relativenumber

" NERDTree config
let g:NERDTreeChDirMode = 2 " Change working dir to NERDTree dir
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['.pyc']

" Gitgutter
let g:gitgutter_grep = ''
let g:gitgutter_signs = 0

"""""""""""""""""""""""""""""""
" MISC COMMANDS AND FUNCTIONS "
"""""""""""""""""""""""""""""""

" Enable or disable text wrapping
command! NoTextWrap :set formatoptions-=t
command! TextWrap :set formatoptions+=t

" Copy filename and line number
command! CopyPlace :let @+ = expand("%") . ":" . line(".")

""""""""""""""""
" KEY MAPPINGS "
""""""""""""""""

" Handy shortcut for replacing words
map <Leader>r :%s/\<<C-r><C-w>\>/

" Syntax checking
map <Leader>c :SyntasticCheck<CR>
map <Leader>C :SyntasticReset<CR>

" Manual spelling toggle
map <Leader>s :Spell<CR>
map <Leader>S :SpellOff<CR>

" Find shortcuts
map <Leader>f :Files<CR>
map <Leader>b :Buffers<CR>

" easymotion word jumping
map <Leader>j <Plug>(easymotion-bd-w)
nmap <Leader>j <Plug>(easymotion-overwin-w)

" Code format shortcut
map <Leader>F :Autoformat<CR>

" Toggle NERDTree
map <Leader>n :NERDTreeToggle<CR>

" Toggle tagbar
map <Leader>t :TagbarToggle<CR>

" Easy indent/unindent
vmap < <gv
vmap > >gv

" Fast saving and exiting
nmap <Leader>w :w<CR>
nmap <Leader>x :x<CR>
nmap <Leader>q :q<CR>
