# Compiling

## `clang`

```
clang -framework Foundation myprogram.m -o myprogram
```

## `gcc`

```
gcc hello_world_class.m -framework Foundation -o a.out
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
