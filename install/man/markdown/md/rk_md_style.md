- Use real headers (`## Foo`) instead of bold-as-header (`**Foo:**`)
- Use headers to introduce lists instead of indented hierarchical lists. E.g., don't do `1. **Foo**` followed by indented sub-items; instead use a header (`### Foo`) followed by a flat list.

# Code Pointer Format

When referencing code in Markdown files, use a two-block format: a `grep` fenced code block with the file path in `file:line:col:` format, followed by a language-specific fenced code block with the code snippet.

~~~
``` grep
~/Developer/Scratch/C/hello_world.c:3:1:
```

``` c
int main() {
    printf("hello, world\n");
}
```
~~~
