def-env fzf_z [] {
  let $result = (~/.bin/z_fzf | str trim)
  cd (if (($result | str length) > 0) {
    $result
  } else {
    "."
  })
}

def-env fzf_o [] {
  let $result = (fd --strip-cwd-prefix --follow --hidden --max-depth 1 --exclude .DS_Store --exclude .git --exclude .hg | str trim | str collect (char nl) | fzf | str trim)
  if (($result | str length) == 0) {
     return
  }
  if ($result | path type) == "file" {
    nu -c ($"($env.EDITOR) " + $result)
    return
  }
  cd (if (($result | str length) > 0) {
      $result
  } else {
      "."
  })
}
