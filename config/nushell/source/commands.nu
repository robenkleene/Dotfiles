def-env s [] {
  ssh_start
  do --ignore-errors {
    # This prints a blank line for some reason
    (egit -p)
  }

  let gitnext = (egitn)
  cd (if (($gitnext | length) > 0) {
    $gitnext
  } else {
    "."
  })
  if (($gitnext | length) == 0) {
    print "Auto"
    if ("~/.personal" | path exists) {
      sgitt -cp
    } else {
      sgitt -c
    }
  }
}

def-env egitn [] {
  let gitnext = (~/.bin/egit -n | str trim)

  # Why do empty strings have a length of `1`?
  if (($gitnext | str length) > 0) {
    cd $gitnext
    pwd
    git -c color.status=always status
  }
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
