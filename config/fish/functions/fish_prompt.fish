function fish_prompt
    # Do this first to get the last pipe status before it changes
    set -l last_pipestatus $pipestatus

    set_color $fish_color_comment
    printf '%s' (date "+%I:%M %p")
    if test $SSH_CONNECTION
        printf ' %s%s%s' (set_color $fish_color_host_remote) (prompt_hostname) (set_color normal)
    end

    set_color $fish_color_cwd
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
    printf '%s%s> ' $prompt_status (set_color normal)
end
