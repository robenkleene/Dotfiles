Compiling from the command line:

    gcc hello_world_class.m -framework Foundation

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

## Nullable

### Compiler Checks

To get rid off a null check between `nullable` and `nonnull` just add a cast like `(NSURL *)` which `null_unspecified`.

### Annotations

Properties:

    @property (nonatomic, strong, nonnull) NSString *key;

Pointers:

    (NSString * _Nonnull)key
