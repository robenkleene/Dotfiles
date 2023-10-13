%

# C Struct

Declare a `struct`:

``` c
struct point {
    int x;
    int y;
};
```

Declare a `struct` variable:

``` c
struct point pt;
```

A `struct` variable can be declared and initialized at once by providing member values:

``` c
struct point maxpt = { 320, 200 };
```

Member values can be accessed with dot notation:

``` c
printf("%d, %d\n", pt.x, pt.y);
```

Declaring a `struct1` and a variable at the same time;

``` c
struct point {
    int x;
    int y;
} myPoint;

int main() {
    myPoint.x = 5;
    myPoint.y = 10;
}
```

Declaring a `struct` with a `typedef`:

``` c
typedef struct {
    int x;
    int y;
} point_t;

int main() {
    point_t maxpt = { 320, 200 };
}
```

You can't use a `typedef` being defined within a `struct` itself, but you can't use a type name, resulting in the following:

``` c
typedef struct node {
    int val;
    struct node *next;
} node_t;
```
