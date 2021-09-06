function fish_set_colors
    set -U fish_color_normal white
    set -U fish_color_command cyan
    set -U fish_color_quote green
    set -U fish_color_redirection white
    set -U fish_color_end yellow
    set -U fish_color_error red red
    set -U fish_color_param blue
    set -U fish_color_match blue
    set -U fish_color_selection --background=cyan #E6B450
    set -U fish_color_history_current --bold
    set -U fish_color_operator white
    set -U fish_color_escape blue
    set -U fish_color_cwd blue
    set -U fish_color_cwd_root red
    set -U fish_color_valid_path --underline
    set -U fish_color_autosuggestion 808080 #808080
    set -U fish_color_user brgreen
    set -U fish_color_host normal
    set -U fish_color_cancel -r
    set -U fish_pager_color_completion normal
    set -U fish_pager_color_description B3A06D yellow #B3A06D
    set -U fish_pager_color_prefix normal --bold --underline
    set -U fish_pager_color_progress brwhite --background=cyan
    set -U fish_color_comment 808080 #808080
    set -U fish_color_search_match black --background=$fish_color_comment
end
