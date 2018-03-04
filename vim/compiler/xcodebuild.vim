set makeprg=
      \xcodebuild
      \\ -alltargets
      \\ -configuration\ Debug
set errorformat=
      \%f:%l:%c:%.%#\ error:\ %m,
      \%f:%l:%c:%.%#\ warning:\ %m,
      \%f:%l:%.%#\ error:\ %m,
      \%f:%l:%.%#\ warning:\ %m,
      \%-G%.%#
