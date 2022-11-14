# if test -f "$HOME/.personal"
#     alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto" && sgitt -cp'
# else
#     # Don't automatically commit on non-personal machines
#     alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto"; sgitt -p'
# end

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

def ut [] {
  ssh_start
  git_pull_all -t
}

def ua [] {
  ssh_start
  git_pull_all
}

def u [] {
  ssh_start
  egit -u
  ~/Developer/Dotfiles/update.sh
}
