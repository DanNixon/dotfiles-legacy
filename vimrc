set nocompatible
filetype off
set encoding=utf-8

set shell=bash

" Reenable thsi when my PR eventually gets merged
" let g:vundle_default_git_proto='ssh'
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
Bundle 'taglist.vim'
Bundle 'Licenses'
Bundle 'Rip-Rip/clang_complete'
Bundle 'ervandew/supertab'
Bundle 'jnwhiteh/vim-golang'

" Use mouse pointer
set mouse=a

" Use single <Leader> for easymotion
map <Leader> <Plug>(easymotion-prefix)

" PyLint config
let g:syntastic_java_checkers = []
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
let g:clang_complete_auto=0

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

"
" 80 CHAR WIDTH WARN
"

highlight CharLim ctermbg=130 guibg=#592929
highlight link CharLimMatch NONE
match CharLimMatch /\%81v.\+/

let s:showOverLength = 0

fun ToggleShowOverLength()
  if s:showOverLength
    hi link CharLimMatch NONE
    let s:showOverLength = 0
  else
    hi link CharLimMatch CharLim
    let s:showOverLength = 1
  endif
endfun

"
" DMENU FIND FUNCTIONS
" Modified from: http://leafo.net/posts/using_dmenu_to_open_quickly.html
"

" Strip the newline from the end of a string
function! Chomp(str)
    return substitute(a:str, '\n$', '', '')
  endfunction

" Find a file and pass it to cmd
function! DmenuOpen(findCmd, cmd)
  let fname = Chomp(system(a:findCmd . " | dmenu -i -l 20 -p " . a:cmd))
  if empty(fname)
    return
  endif
    execute a:cmd . " " . fname
endfunction

"
" KEY MAPPINGS
"

" 80 char limit warning
map <Leader>8 :call ToggleShowOverLength()<CR>

" Manual spelling toggle
map <Leader>ss :Spell<CR>
map <Leader>s :SpellOff<CR>

" Find shortcuts
" FuzzyFind
map <silent> <Leader>f :FufLine<CR>
map <silent> <Leader>o :FufCoverageFile<CR>
" dmenu
map <silent> <Leader>ff :call DmenuOpen("git ls-files", "e")<CR>
map <silent> <Leader>ft :call DmenuOpen("git ls-files", "tabe")<CR>

" Toggle folding
map <Leader>z zA
map <Leader>a zR

" Commenting
map <C-X> gcc
vmap <C-X> gc

" Copy/paste
map <C-C> "+yy
vmap <C-C> "+y
map <C-V> "+p

" Toggle NERDTree on Leader-n
map <Leader>n :NERDTreeToggle<CR>

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

" Easy indent/unindent
vnoremap < <gv
vnoremap > >gv

map <silent> <Leader>, <<
map <silent> <Leader>. >>

" I have a habit of not releasing shift fast enough
command W :w
command Q :q
command Qa :qa
