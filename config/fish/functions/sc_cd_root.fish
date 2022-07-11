function sc_cd_root
    if git rev-parse --is-inside-work-tree &> /dev/null
        git_cd_root
    else
        hg_cd_root
    end
end
