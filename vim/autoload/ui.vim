function! ui#MyNeomakeStatus() abort
  if !exists('*neomake#statusline#LoclistCounts')
    return ''
  endif
  " Count all the errors, warnings
  let total = 0
  for value in values(neomake#statusline#LoclistCounts())
    let total += value
  endfor
  for value in items(neomake#statusline#QflistCounts())
    let total += value
  endfor
  if total == 0
    return ''
  endif
  return 'E' . total . ' '
endfunction

function! ui#MyGitGutterStatus() abort
  if !exists('*GitGutterGetHunkSummary')
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added,
        \ g:gitgutter_sign_modified,
        \ g:gitgutter_sign_removed
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  if len(ret) == 0
    return ''
  endif
  return join(ret, ' ') .  ' '
endfunction
