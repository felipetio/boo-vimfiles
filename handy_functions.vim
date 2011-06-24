function ClearTrailingSpaces() range
  let number_of_trailing_spaces = search('\s\+$', 'nw')
  let has_trailing_spaces = number_of_trailing_spaces != 0
  if has_trailing_spaces
    if a:firstline == a:lastline
      let rang = '%'
    else
      let rang = a:firstline .','. a:lastline
    endif
    let save_cursor = getpos(".")
    execute rang . 's/\s\+$//g'
    echo "lines cleared"
    call setpos('.', save_cursor)
  else
    echo "no trailing spaces found"
  endif
endfunction

command -range ClearTrailingSpaces <line1>,<line2>call ClearTrailingSpaces()

function! ChangeFileencoding()
  " Add more encodings here
  let encodings = ['latin1', 'utf8']
  let prompt_encs = []
  let index = 0
  while index < len(encodings)
    call add(prompt_encs, index.'. '.encodings[index])
    let index = index + 1
  endwhile
  let choice = inputlist(prompt_encs)
  if choice >= 0 && choice < len(encodings)
    execute 'e ++enc='.encodings[choice].' %:p'
  endif
endf
nmap <F8> :call ChangeFileencoding()<CR>

