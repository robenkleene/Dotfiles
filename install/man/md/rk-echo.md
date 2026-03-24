- `echo foo`: Print with new line
- `echo -n foo`: Print without new line
- `echo "Error" >&2`: Echo to standard error

# Notes

Add the `-e` flag to interpret backslashes:

```
echo -e "foo\nbar"
```
