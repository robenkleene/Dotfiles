# Fish template

``` fish
#!/usr/bin/env fish


```

# `uname` switch statement

``` fish
switch (uname)
    case Linux
            echo Hi Tux!
    case Darwin
            echo Hi Hexley!
    case FreeBSD NetBSD DragonFly
            echo Hi Beastie!
    case '*'
            echo Hi, stranger!
end
```

# For in

``` fish
for ${1:file} in (${2:ls})
    echo $$1
end
```

# For in one-liner

``` fish
for ${1:file} in (${2:ls}); echo $$1; end
```

