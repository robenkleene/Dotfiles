function fish_prompt
    # Do this first to get the last pipe status before it changes
    set -l last_pipestatus $pipestatus
    set -l normal (set_color normal)

    set_color $fish_color_comment
    printf '%s' (date "+%I:%M %p")
    if test $SSH_CONNECTION
        # echo -n -s "$USER" $normal @ (set_color $color_host) (prompt_hostname) $normal
        printf ' %s%s%s' (set_color $fish_color_host_remote) (prompt_hostname) $normal
    end

    set_color $fish_color_cwd
    # Alternative for `git` integration
    # if test -e .git
    #     echo -n '.'
    # else
    #     echo -n (prompt_pwd)
    # end
    printf ' %s' (prompt_pwd)

    # Exclude zoxide background process
    # set -l bg_jobs_count (count (jobs --command | grep -v '^zoxide$' || true))
    set -l bg_jobs_count (count (jobs --command || true))
    if test $bg_jobs_count -gt 0
        set_color yellow
        printf ' &%s' $bg_jobs_count
    end

    # Write pipestatus
    set -l prompt_status \
        (__fish_print_pipestatus " " "?" "|" \
            (set_color $fish_color_status) \
            (set_color $fish_color_status) \
            $last_pipestatus)
    printf '%s%s> ' $prompt_status $normal
end

# `git` right prompt
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
