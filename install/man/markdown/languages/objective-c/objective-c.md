# Compiling

## `clang`

If `-o myprogram` is omitted, it will use `a.out` by default.

```
clang -framework Foundation foo.m -o foo
```

## `gcc`

```
gcc foo.m -framework Foundation -o foo
```

# Example

Here's a simple working program:

``` objective-c
#import <Foundation/Foundation.h>

@interface SampleClass : NSObject
- (void)sampleMethod;
@end

@implementation SampleClass
- (void)sampleMethod {
    NSLog(@"Hello, World! \n");
}
@end

int main() {
    SampleClass *sampleClass = [[SampleClass alloc] init];
    [sampleClass sampleMethod];
    return 0;
}
```

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
