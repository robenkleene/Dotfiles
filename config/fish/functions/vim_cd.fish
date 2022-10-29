function vim_cd
  set -l tempfile '/tmp/vim.robenkleene/chdir/chdir'
  truncate -s 0 $tempfile
  eval $VIM_COMMAND $argv
  if test -f $tempfile
    if test (cat $tempfile) != (pwd)
      cd (cat $tempfile)
    end
  end
end
