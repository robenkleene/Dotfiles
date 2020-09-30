function git_cd_root
  cd (string escape (git rev-parse --show-toplevel))
end
