%

# Rust Tests

Use the `#[test]` attribute to specify tests.

## Diffing Comparison

When comparing results, the expected output is usually displayed first. E.g., in the following `assert_cmd` example, the contents of `result` will be displayed first (i.e., as `original`):

```
mov()
    .current_dir("tests/data/simple")
    .write_stdin(input)
    .args(&["changes", "altered"])
    .assert()
    .success()
    .stdout(result);
```

```
├── original: --- original
│   +++ modified
│   @@ -1 +1 @@
│   -changes
│   +altered
│   test
├── diff:
│   ---         orig
│   +++         var
│   @@ -4,0 +5 @@
│   +\ No newline at end of file
│   @@ -6 +7 @@
│   -test
│   +\ No newline at end of file
└── var as str: --- original
    +++ modified
    @@ -1 +1 @@
    -changes
    \ No newline at end of file
    +altered
    \ No newline at end of file
```
