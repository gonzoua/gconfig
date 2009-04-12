" Description:  mason indenter
" Author:       Alexander Timoshenko <gonzo@univ.kiev.ua>
" Last Change:  Sat May 28 14:46:36 EEST 2005
 

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif

" Load perl indenting 
runtime! indent/perl.vim
unlet b:did_indent

" TODO: may be here should be html indenting?

let b:did_indent = 1

" Is syntax highlighting active ?
let b:indent_use_syntax = has("syntax") && &syntax == "mason"

setlocal indentexpr=GetMasonIndent()
setlocal indentkeys+=0=,0),=EO,=>

" Only define the function once.
if exists("*GetMasonIndent")
    finish
endif

function GetMasonIndent()
    " Get the line to be indented
    let cline = getline(v:lnum)

    " Don't reindent coments on first column
    " if cline =~ '^#.'
        " return 0
    " endif

    " Get current syntax item at the line's first char
    let id1 = synID(line("."), col("."), 1)
    let tid1 = synIDtrans(id1)
    let synid = "group: " . synIDattr(id1, "name")
    echohl MoreMsg
    echo synid . "run"
    echohl None
    return GetPerlIndent()
endfunction

