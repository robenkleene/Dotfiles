# if test -f "$HOME/.personal"
#     alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto" && sgitt -cp'
# else
#     # Don't automatically commit on non-personal machines
#     alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto"; sgitt -p'
# end

# def u [] {

# }
# def ut [] {

# }
# def ua [] {

# }

def-env s [] {
  ssh_start
  do --ignore-errors {
    (egit -p)
  }
  if ((egitn | length) == 0) {
    print "Auto"
    sgitt -cp
  }
}
def-env egitn [] {
  let gitnext = (~/.bin/egit -n)
  if (($gitnext | length) > 0) {
    cd $gitnext
    pwd
    git status
  }
  cd (if (($gitnext | length) > 0) {
    $gitnext
  } else {
    .
  })
  $gitnext
}

def ssh_start [] {
  if ((uname | str trim) == "Linux") {
    ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -i -r -d | load-env
  }
}

