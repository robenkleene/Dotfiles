function egitn
  set -l gitnext (~/.bin/egit -pn)
  if test -n $gitnext
    cd $gitnext
    pwd
    git status
  end
end
