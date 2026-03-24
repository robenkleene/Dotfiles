# Print variable

``` swift
print("$1 =", ${1})
```

# Print

``` swift
print("${1:Message}")
```

# Print optional variable

``` swift
print("$1 =", ${1} ?? "nil"
```

# Swift template

``` swift
#!/usr/bin/swift

$0
```

# Delegate

``` swift
protocol ${1:MyClass}Delegate {
    func ${2:handleEvent}(for: $1})
    func ${1/.*/\l$0/}(_  ${1/.*/\l$0/}: $1, ${3:valueForKey} ${4:key}: ${5:String}) -> ${6:Any}
}
```

# Weak self strong self

``` swift
guard let \`self\` = self else { return }
```

# Protocol

``` swift
protocol ${1:MyType} {
    $0
}
```

# Log variable

``` swift
NSLog("$1 = \(${1:result})")
```

# Log

``` swift
NSLog("${1:Hello World}")
```

# For

``` swift
for ${1:i} in ${2:0}..<${3:10} {
    ${0:print("\($1)")}
}
```

# Class

``` swift
class ${1:MyObject} {
    $0
}
```

# Expectation

``` swift
let ${1:expect} = expectation(description: "${2:Expectation}")
$1.fulfill()
waitForExpectations(timeout: ${3:1.0}, handler: nil)
```

# `do-catch`

``` swift
do {
    ${1:${VISUAL:try someThrowingFunction()/try!/try/g}}
} catch {
    ${2:throw error}
}
```

