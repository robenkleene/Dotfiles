function fish_prompt
    set -l last_pipestatus $pipestatus
    set -l normal (set_color normal)

    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus " " "?" "|" (set_color $fish_color_status) (set_color $fish_color_status) $last_pipestatus)
    # Exclude zoxide background process
    # set -l bg_jobs_count (count (jobs --command | grep -v '^zoxide$' || true))
    set -l bg_jobs_count (count (jobs --command || true))

    set_color $fish_color_comment
    echo -n (date "+%I:%M %p")
    if test $SSH_CONNECTION
        echo -n ' '
        # echo -n -s "$USER" $normal @ (set_color $color_host) (prompt_hostname) $normal
        echo -n -s (set_color $color_host) (prompt_hostname) $normal
    end
    echo -n ' '

    set_color $fish_color_cwd
    # if test -e .git
    #     echo -n '.'
    # else
    #     echo -n (prompt_pwd)
    # end
    echo -n (prompt_pwd)

    if test $bg_jobs_count -gt 0
        set_color yellow
        echo -n " &$bg_jobs_count"
    end
    set_color normal
    echo -n $prompt_status

    echo -n ' > '
end

# function fish_right_prompt
#     set_color cyan
#     if test -e .git
#         echo -n (basename $PWD)
#     else
#         set -l git_path (git rev-parse --show-toplevel 2>/dev/null)
#         if test $status -eq 0
#             echo -n (basename $git_path)
#         end
#     end
#     set_color normal
#     echo -n (fish_git_prompt)
# end
