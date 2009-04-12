syntax on
set noerrorbells
set visualbell
set ruler
set backspace=start,indent,eol
set diffopt+=iwhite
" set ignorecase

" Enable auto loading of plugin and ident
filetype indent on
filetype plugin on
set si

" Set to previous editing position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" read skeletons for new files
autocmd BufNewFile *.h call New_H_File()
autocmd BufNewFile *.hpp call New_H_File()
autocmd BufNewFile *.hxx call New_H_File()
autocmd BufNewFile *.hh call New_H_File()
" Adds guard for C/C++ header files
function New_H_File()
    0r ~/.vim/skeletons/skeleton.h
    exe "normal GO#ifndef __" .  toupper(expand('%:t:r')) .
    \ "_H__\<CR>#define __" . toupper(expand('%:t:r')) . "_H__\<CR>\<CR>#endif // __". 
    \ toupper(expand('%:t:r')) . "_H__\<Esc>1G" 
endfunction

function InsertGuard()
    return "#ifndef __" .  toupper(expand('%:t:r')) .
    \ "_H__\<CR>#define __" . toupper(expand('%:t:r')) . "_H__\<CR>\<CR>#endif // __" .
    \ toupper(expand('%:t:r')) . "_H__"
endfunction
inoremap <expr> #guard InsertGuard()

" Create file with C/C++ skeleton
autocmd BufNewFile *.cpp call New_CPP_File()
autocmd BufNewFile *.cc call New_CPP_File()
autocmd BufNewFile *.C call New_CPP_File()
autocmd BufNewFile *.c call New_CPP_File()
autocmd BufNewFile *.cxx call New_CPP_File()
function New_CPP_File()
    0r ~/.vim/skeletons/skeleton.cpp
    exe "normal G"
endfunction

" Create file with perl skeleton
autocmd BufNewFile *.pl call New_Perl_File()
function New_Perl_File()
    0r ~/.vim/skeletons/skeleton.pl
    exe "normal G"
endfunction

" Create file with python skeleton
autocmd BufNewFile *.py call New_Py_File()
function New_Py_File()
    0r ~/.vim/skeletons/skeleton.py
    exe "normal G"
endfunction

set statusline=%<%f%h%m%r%=Dec\ %b\ Hex\ 0x%B\ \ %l,%c%V\ --%p%%--
set foldmethod=marker

" Perforce-related commands
function! P4(command)
	execute "!p4 " . a:command . ' %'
	call feedkeys("\<CR>") 
	edit
	call feedkeys("\<CR>") 
endfunction
command! -nargs=0 Pfe execute "call P4('edit')"
command! -nargs=0 Pfa execute "call P4('add')"

" Abbreviations for C/C++
iabbr #i #include
iabbr #d #define

autocmd BufNewFile,BufRead *.txt call TXT_Style()
" For text files
fun! TXT_Style()
    setlocal noai
    setlocal nosi
    " setlocal textwidth=78

    setlocal shiftwidth=4
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal expandtab
endfun  


let g:smart_cr = {}
let g:smart_cr.c = [['^#include <', '^>$', "#include \<@@@>"],
                     \['^#include "', '^"$', "#include \"@@@\""]]

:nmap <F5> :make<CR>
:nmap <F8> :cn<CR>

nnoremap ' `
nnoremap ` '
let mapleader = ","
" set wildmode=list:longest
set scrolloff=3
set listchars=tab:>-,trail:ž,eol:$
nmap <silent> <leader>s :set nolist!<CR>
set shortmess=atI

" autocmd FileType python compiler pylint
