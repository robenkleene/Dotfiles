%

# C Initialization

Quoting the C standard [local variable initialized to zero in C - Stack Overflow](https://stackoverflow.com/questions/21152138/local-variable-initialized-to-zero-in-c):

> If an object that has automatic storage duration is not initialized explicitly, its value is indeterminate.

> If an object that has static storage duration is not initialized explicitly, then:

> if it has pointer type, it is initialized to a null pointer;
> if it has arithmetic type, it is initialized to (positive or unsigned) zero;
> if it is an aggregate, every member is initialized (recursively) according to these rules;
> if it is a union, the ﬁrst named member is initialized (recursively) according to these rules.

Summarized: Local variables are not initialized to `0`. Static variables are. All global variables are implicitly static, so they are to.
