# Print variable

``` c
printf("$1 = %${2:i}\n", ${1});
```

# Print

``` c
printf("${1:Message}\n");
```

# C template

``` c
#include <stdio.h>

int main() {
    printf("hello, world\n");
}
```

# printf variable

``` c
printf("$1 = %${2:i}\n", ${1:result});
```

# For loop

``` c
for (int ${1:i} = 0; $1 < ${2:10}; $1++) {
    $0
}
```

# While character loop

``` c
while ((c = getchar()) != EOF) {
	$0
}
```

