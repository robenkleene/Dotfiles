def-env fzf_z [] {
  let $result = (zoxide query --list | str trim | str collect (char nl) | fzf | str trim)
  cd (if (($result | str length) > 0) {
    $result
  } else {
    "."
  })
}

def-env fzf_c [] {
  let $result = (fd --strip-cwd-prefix --type d --hidden --follow --max-depth 1 --exclude .git --exclude .hg | str trim | str collect (char nl) | fzf | str trim)
  cd (if (($result | str length) > 0) {
    $result
  } else {
    "."
  })
}

def-env fzf_o [] {
  let $result = (fd --strip-cwd-prefix --type f --follow --type l --hidden --max-depth 1 --exclude .DS_Store | str trim | str collect (char nl) | fzf | str trim)
  if (($result | str length) > 0) {
    nu -c ($"($env.EDITOR) " + $result)
  }
}
