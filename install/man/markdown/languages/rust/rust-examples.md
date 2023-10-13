# Rust Examples

## Map

```
let paths: Vec<PathBuf> = ["changes/", "changes/stays", "stays/"].iter().map(|a| PathBuf::from(a)).collect();
```
