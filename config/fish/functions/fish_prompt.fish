set fish_color_comment 555555
set -xg fish_color_search_match black --background=$fish_color_comment

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch cyan

function fish_prompt
  set -l last_pipestatus $pipestatus
  set -l normal (set_color normal)

  # If we're running via SSH, change the host color.
  set -l color_host $fish_color_host
  if set -q SSH_TTY
      set color_host $fish_color_host_remote
  end

  # Write pipestatus
  set -l prompt_status (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)
  # Exclude fasd background process
  set -l bg_jobs_count (count (jobs --command | grep -v '^fasd$' || true))

  set_color $fish_color_comment
  echo -n (date "+%I:%M %p")
  if test $SSH_CONNECTION
    echo -n ' '
    echo -n -s "$USER" $normal @ (set_color $color_host) (prompt_hostname) $normal
  end
  echo -n ' '
  set_color $fish_color_cwd
  if test -e .git
    echo -n '.'
  else
    echo -n (prompt_pwd)
  end
  if test $bg_jobs_count -gt 0
    set_color yellow
    echo -n " \$$bg_jobs_count"
  end
  set_color normal
  echo -n $prompt_status
  if test $SSH_CONNECTION
    echo -n ' >> '
  else
    echo -n ' > '
  end
end

function fish_right_prompt
  if test -e .git
    set_color cyan
    echo -n (basename $PWD) 
  end
  echo -n (__fish_git_prompt) 
end
