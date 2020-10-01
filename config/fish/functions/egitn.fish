function egitn
  set -l gitnext (~/.bin/egit -n)
  if test -n $gitnext
    cd $gitnext
  end
end
