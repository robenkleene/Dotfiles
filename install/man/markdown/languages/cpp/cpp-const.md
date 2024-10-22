
```
class qux
    const foo bar(const baz) const {
                             ^ This function won't mutate the object, i.e., won't touch any member variables of `qux` (unless those member variables are marked `mutable`)
                  ^ This function can't modify `baz`
    ^ The returned values of type `foo` can't be modified by the caller, i.e., only functions marked `const` can be called on instances of `foo` returned by this method
    //
    }
}
```
