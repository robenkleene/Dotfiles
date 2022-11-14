if ((which 'zoxide' | length) > 0) {
  let-env config = ($env.config | update hooks.env_change.PWD ($env.config.hooks.env_change.PWD | append {|_, dir|
    zoxide add -- $dir
  }))
}

