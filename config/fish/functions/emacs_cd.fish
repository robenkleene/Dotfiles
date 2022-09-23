function emacs_cd
  set -l tempfile '/tmp/vim.robenkleene/chdir/chdir'
  if ! test -f $tempfile
    mkdir -p /tmp/vim.robenkleene/chdir/
    touch $tempfile
  end
  eval $EMACS_COMMAND $argv
  if test -f $tempfile
    if test (cat $tempfile) != (pwd)
      cd (cat $tempfile)
    end
  end
end
