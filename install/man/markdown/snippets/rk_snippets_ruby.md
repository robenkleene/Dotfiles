# Print variable

``` ruby
puts "$1 = #{${1}}"
```

# Print

``` ruby
puts "${1:Message}"
```

# Print error

``` ruby
STDERR.puts "$1{:Error}"
```

# rk_template

``` ruby
#!/usr/bin/env ruby


```

# For loop

``` ruby
for i in ${1:0}..${2:10}
  ${0:puts i}
end
```

# For in loop

``` ruby
${1:ARGV}.each do |${2:item}|
  ${0:puts $2}
end
```

# Each loop

``` ruby
(${1:0}..${2:10}).each do |i|
  ${0:puts i}
end
```

