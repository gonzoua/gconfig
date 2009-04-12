" Conform to style(9).
fun! CPP_Style()
    setlocal cindent
    setlocal formatoptions=clnoqrt
    setlocal textwidth=80

    setlocal indentexpr=IgnoreParenIndent()
    setlocal shiftwidth=4
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal expandtab
endfun  

call CPP_Style()
