# Rust template

``` rust
fn main() {
    ${1:println!("Hello, world!");}
}

```

# Rust result template

``` rust
use std::io;

fn main() -> io::Result<()> {
    ${1:println!("Hello, world!");}
Ok(())
}

```

# Match `Some`

``` rust
match ${1:optional} {
  Some($1) => $1,
  None => ${2:println!("No value")}
}
```

# Match result

``` rust
match ${1:result} {
  Ok($1) => $1,
  Err(err) => panic!("Error: {}", err)
}
```

