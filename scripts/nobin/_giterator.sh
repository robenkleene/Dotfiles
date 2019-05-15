usage() {
  echo "Usage: $command_name [-pln]"
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
while getopts "plcm:nh" option
  do case "$option" in
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

do_git_process() {
  if ! [[ -d ".git" ]]; then
    return
  fi
  nothing_to_commit="false"
  status=$(git status)

  # Test git status message 1.
  nothing_to_commit_message="nothing to commit (working directory clean)"
  test "${status#*$nothing_to_commit_message}" != "$status" && nothing_to_commit="true"
  # Test git status message 2.
  nothing_to_commit_message="nothing to commit, working directory clean"
  test "${status#*$nothing_to_commit_message}" != "$status" && nothing_to_commit="true"
  # Test git status message 3.
  nothing_to_commit_message="nothing to commit, working tree clean"
  test "${status#*$nothing_to_commit_message}" != "$status" && nothing_to_commit="true"

  if $next; then
    if ! $nothing_to_commit; then
      pwd
      break
    fi
  else
    echo
    pwd
    git status
  fi

  if [[ "$push" == "true" && "$nothing_to_commit" == "true" ]] ; then
    # Test `origin/master..master` to only push if there are local changes to
    # push
    if ! git diff --exit-code origin/master..master > /dev/null; then
      git push
    fi
  elif [[ "$pull" == "true" && "$nothing_to_commit" == "true" ]] ; then
    git pull
  elif [[ -n "$message" && "$nothing_to_commit" == "false" ]]; then
    git add -A :/ && git commit -m "$message"
  fi
}

giterate() {
  dir=$1
  if [[ -d "$dir" ]]; then
    cd "$1"
    do_git_process
    cd - >/dev/null
  else
    if ! $next; then
      echo
      echo "Directory does not exist $dir"
    fi
  fi
}
