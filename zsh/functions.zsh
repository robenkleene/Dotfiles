egitn() {
  # The reason `egitn` has to be run seprately after `egit` is because the
  # second time running `egit` can't print except the path.
  print_status="true"
  while getopts ":n" option; do
    case "$option" in
      n)
        print_status="false"
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    esac
  done

  local gitnext
  gitnext=$(egit -n)
  if [[ -n "$gitnext" ]]; then
    cd "$gitnext" || return
    if [[ "$print_status" == "true" ]]; then
      pwd
      git status
    fi
    return 1
  fi
}

ssh_git_pull_all() {
  ssh_start
  git_pull_all "$@"
}

ssh_start() {
  if [[ "$(uname)" = "Linux" && -z "$SSH_AGENT_PID" ]]; then
    eval "$(ssh-agent -s)"
    ssh-add
  fi
}

ssh_stop() {
  ssh-agent -k
}

# Accepts one history line number as argument.
# `dc` with no arguments deletes the most recent line
# Use `dc -1` to remove the last line.
# The naming convention `dc` is probably based on `fc` which is the underlying
# history management program for Bash and Zsh. `fc` stands for "fix command"
# (because with history you retrieve a command and can then fix it). So `dc`
# probably stands for "delete command".
dc () {
  # Default to the most recent line
  line="${@:--1}"
  # If the line starts with `-` treat is a most recent history
  # Otherwise remove the line itself
  if [ "${line[1]}" = '-' ]; then
    line="${(b)$(fc -ln $line $line)}"
  fi
  # Prevent the specified history line from being
  # saved.
  local HISTORY_IGNORE="${(b)line}"

  # Write out the history to file, excluding lines that
  # match `$HISTORY_IGNORE`.
  fc -W

  # Dispose of the current history and read the new
  # history from file.
  fc -p $HISTFILE $HISTSIZE $SAVEHIST

  # TA-DA!
  print "Deleted '$HISTORY_IGNORE' from history."
}
# Never add `dc` commands to history
zshaddhistory() {
 [[ $1 != 'dc '* ]]
}
