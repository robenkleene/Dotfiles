``` swift
do {
    let foo = try getFoo()
} catch FooError.invalidFoo {
    fatal("Invalid foo")
} catch {
    fatal("\(error)")
}
```
