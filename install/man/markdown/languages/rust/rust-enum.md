# Rust `enum`

Setup:

```
enum DeleteKind {
    None,
    Delete,
    DeleteAll,
}
```

Check for single variant:

```
if let DeleteKind::None = delete_kind {
```
