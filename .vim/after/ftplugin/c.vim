" Ignore indents caused by parentheses in FreeBSD style.
fun! IgnoreParenIndent()
    let indent = cindent(v:lnum)

    if indent > 4000
        if cindent(v:lnum - 1) > 4000
            return indent(v:lnum - 1)
        else
            return indent(v:lnum - 1) + 4
        endif
    else
        return (indent)
    endif
endfun

" Conform to style(9).
fun! FreeBSD_Style()
    setlocal cindent
    setlocal formatoptions=clnoqrt
    setlocal textwidth=80

    setlocal indentexpr=IgnoreParenIndent()
    setlocal indentkeys=0{,0},0),:,0#,!^F,o,O,e

    setlocal cinoptions=(4200,u4200,+0.5s,*500,t0,U4200
    setlocal shiftwidth=8
    setlocal tabstop=8
    setlocal noexpandtab
endfun  

call FreeBSD_Style()
