function git_cd_root
  cd (git rev-parse --show-toplevel)
end
