function emacs_cd
  set -l tempfile '/tmp/vim.robenkleene/chdir/chdir'
  eval $EMACS_COMMAND $argv
  if test -f $tempfile
    if test (cat $tempfile) != (pwd)
      cd (cat $tempfile)
    end
  end
end
