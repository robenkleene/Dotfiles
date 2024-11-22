# Analysis

When analyzing a complicated tree structure, to figure out whether a node is a descendent of another node, the best method is to use `grep` with an `|` (or) match like this:

```
grep 'property|name' < foo.json
```

E.g., if you want to check whether a node with a particular name has another node with a particular property as an ancestor, we can tell by looking at the indentation.
