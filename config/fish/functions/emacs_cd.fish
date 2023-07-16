function emacs_cd
  set -l tempfile '/tmp/robenkleene.transient/chdir/chdir'
  if ! test -f $tempfile
    mkdir -p /tmp/robenkleene.transient/chdir/
    touch $tempfile
  end
  eval $EMACS_COMMAND $argv
  if test -f $tempfile
    if test (cat $tempfile) != (pwd)
      cd (cat $tempfile)
    end
  end
end
