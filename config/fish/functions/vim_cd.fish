function vim_cd
  set -l tempfile '/tmp/vim.robenkleene/chdir/chdir'
  eval $VIM_COMMAND ./
  if test -f $tempfile
    if test (cat $tempfile) != (pwd)
      cd (cat $tempfile)
    end
  end
end
