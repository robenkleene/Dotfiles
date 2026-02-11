# Print variable

``` vim
echom "$1 = ".${1}
```

# `echom`

``` vim
echom "${1}"
```

# Function

``` vim
function! s:${1:Name}() abort
  ${0:" Statements}
endfunction
```

# `augroup`

``` vim
augroup ${1:writing_buffer}
  autocmd!
  autocmd ${2:BufWrite *} ${3::echom "Writing buffer!"}
augroup END
```

# `xcodebuild test` `makeprg`

``` vim
setlocal makeprg=xcodebuild\ test
			\\\ -alltargets
			\\\ -configuration\ Debug
			\\\ -scheme\ ${1:Scheme}
			\\\ -only-testing:${2:TestTarget}/${3:TestSuite}/${4:TestCase}
```

# Set default

``` vim
set ${0:shell}&
```

# If statement

``` vim
if ${1:has('gui_running')}
  ${2:finish}
endif
```

