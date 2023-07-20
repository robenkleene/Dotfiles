def-env fzf_z [] {
  let $result = (~/.bin/z_fzf | str trim)
  cd (if (($result | str length) > 0) {
    $result
  } else {
    "."
  })
}

def-env fzf_z_subdir [] {
  let $result = (~/.bin/z_subdir_fzf | str trim)
  cd (if (($result | str length) > 0) {
    $result
  } else {
    "."
  })
}

def-env fzf_o [] {
  let $result = (~/.bin/find_ls -f)
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
