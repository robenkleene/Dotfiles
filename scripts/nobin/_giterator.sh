usage() {
  echo "Usage: command [-pln]"
  echo
  echo "No flags : Just lists the status of each repo"
  echo "-c: Stage changes with a default commit message"
  echo "-u : Pull all repos without staged changes"
  echo "-m <message>: Stage changes with commit message"
  echo "-n : Print next directory path with unstaged changes"
  echo "-p : Push all repos without staged changes"
}

push="false"
pull="false"
next="false"
message=""
while getopts "pucm:nh" option; do
  case "$option" in
    p)
      push="true"
      ;;
    u)
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
  local printed="false"
  if ! [ -d ".git" ]; then
    return
  fi
  local nothing_to_commit
  nothing_to_commit=$(commit_status)

  if $next; then
    if ! $nothing_to_commit; then
      pwd
      exit 0
    else
      return 0
    fi
  fi

  if [ "$nothing_to_commit" = "false" ]; then
    if [ -n "$message" ]; then
      if [[ "$printed" = "false" ]]; then
        echo
        pwd
        printed="true"
      fi
      git add -A :/ && git commit -m "$message"
      nothing_to_commit=$(commit_status)
    elif [ "$push" = "true" ]; then
      if [[ "$printed" = "false" ]]; then
        echo
        pwd
        printed="true"
      fi
      # Don't print an error message here, because it will clutter the output.
      # This exit status is used to indicate that there's at least one
      # repository that needs to be addressed manually. Changing to the
      # directory is done by a separate call.
      exit 1
    fi
  fi

  if [ "$push" = "true" ] && [ "$nothing_to_commit" = "true" ]; then
    if ! git diff --exit-code "@{upstream}" >/dev/null; then
      if [[ "$printed" = "false" ]]; then
        echo
        pwd
        printed="true"
      fi
      git push
    fi
  elif [ "$pull" = "true" ] && [ "$nothing_to_commit" = "true" ]; then
    if [[ "$printed" = "false" ]]; then
      echo
      pwd
      printed="true"
    fi
    git pull -r
  fi
}

giterate() {
  dir="$1"
  if [ -d "$dir" ]; then
    cd "$1" || return
    do_git_process
    cd - >/dev/null || return
  else
    if ! $next; then
      echo
      echo "Directory does not exist $dir" >&2
    fi
  fi
}
