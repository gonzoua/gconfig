" Vim syntax file
" Language:     SVK commit file
" Maintainer:   Oleksandr Tymoshenko <gonzo@bluezbox.com>
" URL:          http://gonzo.kiev.ua/files/vim/syntax/svk.vim
" Revision:     $Id$
" Filenames:    svk-commit*.tmp
" Last Change:	2009 Apr 08
" Version:      0.1

" Based on SVN commit file syntax by Dmitry Vasiliev

" For version 5.x: Clear all syntax items.
" For version 6.x: Quit when a syntax file was already loaded.
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn region svkRegion    start="^===.*===$" end="\%$" contains=ALL contains=@NoSpell

syn match svkAdded         "^A.. .*$" contained
syn match svkConflicted    "^C.. .*$" contained
syn match svkDeleted       "^D.. .*$" contained
syn match svkIgnored       "^I.. .*$" contained
syn match svkModified      "^M.. .*$" contained
syn match svkReplaced      "^R.. .*$" contained
syn match svkMissing       "^!.. .*$" contained
syn match svkUncontrolled  "^?.. .*$" contained
syn match svkObstructed    "^\~.. .*$" contained
syn match svkPropsModified "^ [MC]. .*$" contained

" Synchronization.
syn sync clear
syn sync match svkSync  grouphere svkRegion "^===.*===$"me=s-1

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already.
" For version 5.8 and later: only when an item doesn't have highlighting yet.
if version >= 508 || !exists("did_svk_syn_inits")
  if version <= 508
    let did_svk_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink svkRegion          Comment
  HiLink svkIgnored         Comment
  HiLink svkUncontrolled    Comment
  HiLink svkDeleted         Constant
  HiLink svkConflicted      Constant
  HiLink svkMissing         Constant
  HiLink svkObstructed      Constant
  HiLink svkAdded           Identifier
  HiLink svkModified        Special
  HiLink svkPropsModified   Special
  HiLink svkReplaced        Special

  delcommand HiLink
endif

let b:current_syntax = "svk"
