set fish_color_comment 555555
set -xg fish_color_search_match black --background=$fish_color_comment

# Prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch cyan
function fish_prompt
  set_color $fish_color_comment
  echo -n (date "+%I:%M %p")
  echo -n ' '
  echo -n $USER@(prompt_hostname)
  echo -n ' '
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal
  echo -n '> '
end
function fish_right_prompt
  echo -n (__fish_git_prompt)
end
