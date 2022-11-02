function vim_cd
  set -l tempfile '/tmp/vim.robenkleene/chdir/chdir'
  truncate -s 0 $tempfile
  eval $VIM_COMMAND $argv
  if test -f $tempfile
    set -l result (cat $tempfile)
    if test -n $result
      if test "$result" != (pwd)
        cd $result
      end
    end
  end
end
