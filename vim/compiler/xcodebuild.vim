setlocal makeprg=xcodebuild\ -alltargets
setlocal errorformat=%f:%l:%c:%.%#\ error:\ %m,%f:%l:%c:%.%#\ warning:\ %m,%-G%.%#
