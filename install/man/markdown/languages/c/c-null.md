%

# C Null

A pointer can be set to `NULL` and then pointed to a value later:

``` c
typedef struct Node {
    int val;
    struct Node *next;
} Node;

Node *null_node = NULL;
Node *node = (Node *)malloc(sizeof(Node));
node->val = 3;
node->next = NULL;
null_node = node;
printf("null_node->val = %i\n", null_node->val); // 3
```

[`null_test.c`](assets/null_test.c) is a program that illustrates this.
