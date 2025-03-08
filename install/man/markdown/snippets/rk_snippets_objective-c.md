# Print variable

``` objective-c
NSLog(@"$1 = %${2:@}", ${1});
```

# Print

``` objective-c
NSLog(@"${1:Message}");
```

# Objective-C template

``` objective-c
#import <Foundation/Foundation.h>

int main() {
    NSLog(@"Hello, World!");
}
```

# Main

``` objective-c
int main() {
    NSLog(@"Hello, World!");
}
```

# Class

``` objective-c
NS_ASSUME_NONNULL_BEGIN
@interface ${1:MyClass} : NSObject
$2
@end
NS_ASSUME_NONNULL_END

@implementation $1
$0
@end
```

# Delegate

``` objective-c
NS_ASSUME_NONNULL_BEGIN
@protocol ${1:MyClass}Delegate <NSObject>
- (void)handleEventFor$1:($1 *)${2:myObject};
- (${3:id})$2:($1 *)$2 ${4:valueForKey}:(${5:NSString *})${6:key};
@end
NS_ASSUME_NONNULL_END
```

# Protocol

``` objective-c
@protocol ${1:MyProtocol} <NSObject>
$0
@end
```

# Implementation

``` objective-c
@implementation ${1:MyClass}
$0
@end
```

# Interface

``` objective-c
NS_ASSUME_NONNULL_BEGIN
@interface ${1:MyClass} : NSObject
$0
@end
NS_ASSUME_NONNULL_END
```

# Class Extension

``` objective-c
NS_ASSUME_NONNULL_BEGIN
@interface ${1:MyClass} (${2:MyCategory})
$0
@end
NS_ASSUME_NONNULL_END
```

# Property

``` objective-c
@property (nonatomic, strong) ${1:NSString} *${2:identifier};
```

# Delegate property

``` objective-c
@property (nonatomic, assign, nullable) id <${1:MyDelegate}> *delegate;
```

# Assume nonnull block

``` objective-c
NS_ASSUME_NONNULL_BEGIN
${VISUAL}
NS_ASSUME_NONNULL_END
```

# Initialization method

``` objective-c
- (instancetype)initWith${1:Dictionary}:(NSDictionary *)${1/.*/\l$0/}
{
    self = [super init];
    if (self) {
		_${1/.*/\l$0/} = ${1/.*/\l$0/};
    }
    return self;
}
```

# For in

``` objective-c
for (${1:id} ${2:object} in ${3:objects}) {
    $0
}
```

# for

``` objective-c
for (int ${1:i} = ${2:0}; $1 < ${3:10}; $1++) {
    ${0:NSLog(@"%d", i);}
}
```

