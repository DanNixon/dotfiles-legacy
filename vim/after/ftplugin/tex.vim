" Set auto spell checking
setlocal spell spelllang=en_us

" Set command for aspell spell checker
command! ASpell execute "!aspell -t -c %"

" Wrap text
set wrap
