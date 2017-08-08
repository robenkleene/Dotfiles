set makeprg=xcodebuild\ -alltargets\ -configuration\ Debug
set errorformat=%f:%l:%c:%.%#\ error:\ %m,
			\%f:%l:%.%#\ error:\ %m,
			\%f:%l:%c:%.%#\ warning:\ %m,
      \%-G%.%#

" `errorformat` Lines
" 1. Match test failures
" 2. Match build errors
" 3. Match build warnings
" 4. Filter everything else
" `%.%#`: Equivalent to the `.*` regular expression.
