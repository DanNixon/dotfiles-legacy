set nocompatible
set encoding=utf-8

filetype off

"""""""""""""""""
" PLUGIN CONFIG "
"""""""""""""""""

call plug#begin('~/.vim/plugged')

" Used to format and make editing CSV files trivial
Plug 'https://github.com/chrisbra/csv.vim'

" Applies base16 colour themes to syntax highlighting
Plug 'https://github.com/chriskempson/base16-vim'

" Applies formatting rules based on editorconfig files
Plug 'https://github.com/editorconfig/editorconfig-vim'

" Fuzzy finding
Plug 'https://github.com/junegunn/fzf.vim'

" Provides tree based file explorer
Plug 'https://github.com/scrooloose/nerdtree'

" Restores cursor position on opening previously opened files
Plug 'https://github.com/vim-scripts/restore_view.vim'

" Provides syntax checking
Plug 'https://github.com/scrooloose/syntastic'

" Tab completion
Plug 'https://github.com/ervandew/supertab'

" Provides ctags based navigation of current file
Plug 'https://github.com/majutsushi/tagbar'

" Provides powerline style status line
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'

" Invokes code formatting tools from Vim
Plug 'https://github.com/Chiel92/vim-autoformat'

" Provides easy line/block comment toggling
Plug 'https://github.com/tpope/vim-commentary'

" Fast jumping to markers in a file
Plug 'https://github.com/easymotion/vim-easymotion'

" File query/modification commands
Plug 'https://github.com/tpope/vim-eunuch'

" Git commands
Plug 'https://github.com/tpope/vim-fugitive'

" Enhanced spelling and grammar checking
Plug 'https://github.com/reedes/vim-lexical'

" Syntax highlighting
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/sirtaj/vim-openscad'
Plug 'https://github.com/nfnty/vim-nftables'

" Format text into one line per sentance
Plug 'https://github.com/Konfekt/vim-sentencewrap'

" Query and insert unicode characters
Plug 'https://github.com/chrisbra/unicode.vim'

call plug#end()

""""""""""""""""""
" GENERAL CONFIG "
""""""""""""""""""

filetype plugin indent on
syntax on

" Use Space as Leader
let mapleader = " "

" Tagbar config
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

" Syntastic config
let g:syntastic_mode_map = {
      \ 'mode': 'passive',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': []
\ }
let g:syntastic_auto_loc_list = 1
let g:syntastic_aggregate_errors = 1

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

" Highlight current line
set cursorline

" NERDTree config
let g:NERDTreeChDirMode = 2 " Change working dir to NERDTree dir
let g:NERDTreeMinimalUI = 1

"""""""""""""""""""""""""""""""
" MISC COMMANDS AND FUNCTIONS "
"""""""""""""""""""""""""""""""

" Enable or disable text wrapping
command! NoTextWrap :set formatoptions-=t
command! TextWrap :set formatoptions+=t

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
