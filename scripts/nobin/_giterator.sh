usage() {
  echo "Usage: command [-pln]"
  echo
  echo "No flags : Just lists the status of each repo"
  echo "-c: Stage changes with a default commit message"
  echo "-l : Pull all repos without staged changes"
  echo "-m <message>: Stage changes with commit message"
  echo "-n : Print next directory path with unstaged changes"
  echo "-p : Push all repos without staged changes"
}

push="false"
pull="false"
next="false"
while getopts "plcm:nh" option; do
  case "$option" in
    p)
      push="true"
      ;;
    l)
      pull="true"
      ;;
    n)
      next="true"
      ;;
    m)
      message=$OPTARG
      ;;
    c)
      message="Update"
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      echo "Invalid option or missing argument"
      usage
      exit 1
      ;;
  esac
done

commit_status() {
  nothing_to_commit="false"
  status=$(git status)

  nothing_to_commit_message="nothing to commit (working directory clean)"
  if [ "${status#*$nothing_to_commit_message}" != "$status" ]; then
    echo -n "true"
    return
  fi
  nothing_to_commit_message="nothing to commit, working directory clean"
  if [ "${status#*$nothing_to_commit_message}" != "$status" ]; then
    echo -n "true"
    return
  fi
  nothing_to_commit_message="nothing to commit, working tree clean"
  if [ "${status#*$nothing_to_commit_message}" != "$status" ]; then
    echo -n "true"
    return
  fi
  echo -n "false"
}

do_git_process() {
  if ! [ -d ".git" ]; then
    return
  fi
  nothing_to_commit=$(commit_status)

  if $next; then
    if ! $nothing_to_commit; then
      pwd
      exit 0
    fi
  else
    echo
    pwd
    git status
  fi

  if [ -n "$message" ] && [ "$nothing_to_commit" = "false" ]; then
    git add -A :/ && git commit -m "$message"
    nothing_to_commit=$(commit_status)
  fi

  if [ "$push" = "true" ] && [ "$nothing_to_commit" = "true" ]; then
    # Test `origin/master..master` to only push if there are local changes to
    # push
    if ! git diff --exit-code origin/master..master >/dev/null; then
      git push
    fi
  elif [ "$pull" = "true" ] && [ "$nothing_to_commit" = "true" ]; then
    git pull
  fi
}

giterate() {
  dir=$1
  if [ -d "$dir" ]; then
    cd "$1" || return
    do_git_process
    cd - >/dev/null || return
  else
    if ! $next; then
      echo
      echo "Directory does not exist $dir"
    fi
  fi
}
