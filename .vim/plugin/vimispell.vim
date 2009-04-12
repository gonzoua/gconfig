" Use ispell to highlight spellig errors
" Author: Claudio Fleiner <claudio@fleiner.com>
" F6         - write file, spell file & highlight spelling mistakes
" <SHIFT>F6  - switch between german and american spelling
" <ALT>F6    - return to normal syntax coloring
" <ALT>I     - insert word under cursor into directory
" <ALT>U     - insert word under cursor as lowercase into directory
" <ALT>A     - accept word for this session only
" <ALT>/     - check for alternatives

:function! ProposeAlternatives()
:  let @_=CheckSpellLanguage()
:  let alter=system("echo ".expand("<cword>")." | ispell -a -d ".b:language." | sed -e '/^$/d' -e '/^[@*#]/d' -e 's/.*: //' -e 's/,//g' | awk '{ for(i=1;i<=NF;i++) if(i<10) printf \"map %d :let r=SpellReplace(\\\"%s\\\")<CR> | echo \\\"%d: %s\\\" | \",i,$i,i,$i; }'")
:  if alter !=? ""
:    echo "Checking ".expand("<cword>").": Type 0 for no change, r to replace or"
:    exe alter
:    map 0 <cr>:let r=SpellRemoveMappings()<cr>
:    map r 0gewcw
:  else
:    echo "no alternatives"
:  endif
:endfunction

:function! SpellRemoveMappings()
:  let counter=0
:  while counter<10
:    exe "map ".counter." x"
:    exe "unmap ".counter
:    let counter=counter+1
:  endwhile
:  unmap r
:endfunction


:function! SpellReplace(s)
:  exe "normal gewcw".a:s."\<esc>"
:  let r=SpellRemoveMappings()
:endfunction

:function! ExitSpell()
:  unmap <esc>i
:  unmap <esc>u
:  unmap <esc>a
:  unmap <esc>n
:  unmap <esc>p
:  unmap <esc><f6>
:  unmap <m-i>
:  unmap <m-u>
:  unmap <m-a>
:  unmap <m-n>
:  unmap <m-p>
:  unmap <m-f6>
:  syn match SpellErrors "xxxxx"
:  syn match SpellCorrected "xxxxx"
:  syn clear SpellErrors
:  syn clear SpellCorrected
:endfunction

:function! SpellCheck() 
:  syn case match
:  let @_=CheckSpellLanguage()
:  w
:  syn match SpellErrors "xxxxx"
:  syn clear SpellErrors
:  let b:spellerrors="\\<\\(nonexisitingwordinthisdociumnt"
:  let b:mappings=system("ispell -l -d ".b:language." < ".expand("%")." | sort -u | sed 's/\\(.*\\)/syntax match SpellErrors \"\\\\<\\1\\\\>\" ".b:spell_options."| let b:spellerrors=b:spellerrors.\"\\\\\\\\\\\\\\\\|\\1\"/'")
:  exe b:mappings
:  let b:spellerrors=b:spellerrors."\\)\\>"
:  map <ESC>i :let @_=system("echo \\\*".expand("<cword>")." \| ispell -a -d ".b:language)<CR>:syn case match<cr>:exe "syn match SpellCorrected \"\\<".expand("<cword>")."\\>\" transparent contains=NONE ".b:spell_options<cr><cr><c-l>
:  map <ESC>u :let @_=system("echo \\\&".expand("<cword>")." \| ispell -a -d ".b:language)<CR>:syn case ignore<cr>:exe "syn match SpellCorrected \"\\<".expand("<cword>")."\\>\" transparent contains=NONE ".b:spell_options<cr><cr><c-l>
:  map <ESC>a :syn case match<cr>:exe "syn match SpellCorrected \"\\<".expand("<cword>")."\\>\" transparent contains=NONE ".b:spell_options<cr><c-l>
:  map <ESC><F6> :let @_=ExitSpell()<CR>
:  exe "map <esc>n /".b:spellerrors."\<cr>"
:  exe "map <esc>p ?".b:spellerrors."\<cr>"
:  map <m-i> :let @_=system("echo \\\*".expand("<cword>")." \| ispell -a -d ".b:language)<CR>:syn case match<cr>:exe "syn match SpellCorrected \"\\<".expand("<cword>")."\\>\" transparent contains=NONE ".b:spell_options<cr><cr><c-l>
:  map <m-u> :let @_=system("echo \\\&".expand("<cword>")." \| ispell -a -d ".b:language)<CR>:syn case ignore<cr>:exe "syn match SpellCorrected \"\\<".expand("<cword>")."\\>\" transparent contains=NONE ".b:spell_options<cr><cr><c-l>
:  map <m-a> :syn case match<cr>:exe "syn match SpellCorrected \"\\<".expand("<cword>")."\\>\" transparent contains=NONE ".b:spell_options<cr><c-l>
:  map <m-F6> :let @_=ExitSpell()<CR>
:  exe "map <m-n> /".b:spellerrors."\<cr>"
:  exe "map <m-p> ?".b:spellerrors."\<cr>"
:  syn cluster Spell contains=SpellErrors,SpellCorrected
:  hi link SpellErrors Error
:  exe "normal \<cr>"
:endfunction

:function! CheckSpellLanguage() 
:  if !exists("b:spell_options") 
:    let b:spell_options=""
:  endif
:  if !exists("b:language")
:    let b:language="american"
:  elseif b:language !=? "german"
:    let b:language="american"
:  endif
:endfunction

:function! SpellLanguage()
:  if !exists("b:language")
:    let b:language="german"
:  elseif b:language ==? "american"
:    let b:language="german"
:  else
:    let b:language="american"
:  endif
:  echo "Language: ".b:language
:endfunction

map <F6> :let @_=SpellCheck()<cr>
" map <ESC>/ :let @_=ProposeAlternatives()<CR>
map <m-/> :let @_=ProposeAlternatives()<CR>
map <S-F6> :let @_=SpellLanguage()<cr>

