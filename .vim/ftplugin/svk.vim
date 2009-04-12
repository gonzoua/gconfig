" Vim filetype plugin file
" Language:     SVK commit file
" Maintainer:   Oleksandr Tymoshenko <gonzo@bluezbox.com>
" URL:          http://gonzo.kiev.ua/files/vim/ftplugin/svk.vim
" Revision:     $Id$
" Filenames:    svk-commit*.tmp
" Last Change:	2009 Apr 08
" Version:      0.1

" In SVK commit file one can add files that are not under source control
" by changing file status from '?' to 'A'. These plugin automates it adding
" Two keyboard shorcats C-A for adding file and C-X for un-adding it

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif

let b:did_ftplugin = 1

function! SVK_add_file()
  if getline(".")[0] == "?"
	  silent execute 's/^?/A/'
	  " move to the next line
	  call cursor(line(".") + 1, 1)
  endif
endfunction

function! SVK_remove_file()
  if getline(".")[0] == "A"
	  silent execute 's/^A/\?/'
	  " move to the next line
	  call cursor(line(".") + 1, 1)
  endif
endfunction

nmap <buffer> <silent> <C-A> :call SVK_add_file()<CR>
nmap <buffer> <silent> <C-X> :call SVK_remove_file()<CR>
