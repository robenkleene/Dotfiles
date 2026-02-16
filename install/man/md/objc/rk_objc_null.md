# `nullable`

## Properties

```
@property (nonatomic, strong, nonnull) NSString *key;
```

## Pointers

```
(NSString * _Nonnull)key
```

## Compiler Checks

To get rid off a null check between `nullable` and `nonnull` just add a cast like `(NSURL *)` which `null_unspecified`.
