# Shell Script Conventions

- Use lowercase for local variables (e.g., `hostname`, `filename`)
- Reserve UPPERCASE for exported environment variables (e.g., `PATH`, `HOME`)

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

@~/.claude-local/CLAUDE.md
