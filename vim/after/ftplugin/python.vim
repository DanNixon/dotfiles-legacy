" Dont break indentation
" set noexpandtab
set tabstop=4
set shiftwidth=4

" Add Run command
command! Run execute "!python %"

" Reformat
command! SpaceFormat :%s/	/    /g

