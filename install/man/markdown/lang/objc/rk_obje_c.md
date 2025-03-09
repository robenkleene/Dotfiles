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
