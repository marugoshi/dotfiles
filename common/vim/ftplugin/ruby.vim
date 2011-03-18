function! MagicComment()
  return "# -*- coding: utf-8 -*-\<CR>"
endfunction
inoreabbrev <buffer> ## <C-R>=MagicComment()<CR>
