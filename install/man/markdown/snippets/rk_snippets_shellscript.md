# Print variable

``` shellscript
echo "$1 = \$${1}"
```

# Print

``` shellscript
echo "${1:Message}"
```

# Print error

``` shellscript
echo "${1:Error}" >&2
```

# Bash template

``` shellscript
#!/usr/bin/env bash

set -euo pipefail


```

# Echo array variable

``` shellscript
echo "$1 = \${${1}[@]}"
```

# Remove variable trailing slash

``` shellscript
\${${0:1}%/}
```

# Remove path extension

``` shellscript
\${${0:1}%.*}
```

# Get array element

``` shellscript
\${${0:args}[@]}
```

# Function

``` shellscript
${1:my_function}() {
  ${0:echo \$1}
}
```

# Test expression

``` shellscript
[[ ${0:true} ]]
```

# If statement

``` shellscript
if ${1:true}; then
  ${0:echo "true"}
fi
```

# If `uname`

``` shellscript
if [[ "\$(uname)" = "Darwin" ]]; then
  echo "Darwin"
elif [[ "\$(uname)" = "Linux" ]]; then
  echo "Linux"
fi
```

# If args

``` shellscript
if [[ $# ${1:-ne} ${2:0} ]]; then
  ${0:echo "\$1"}
fi
```

# True if directory

``` shellscript
-d "${0:\$1}"
```

# Test boolean

``` shellscript
"$${1:value}" == "${0:true}"
```

# True if regular file

``` shellscript
-f "${0:\$1}"
```

# True if file exists

``` shellscript
-e "${0:\$1}"
```

# True if symbolic link

``` shellscript
-L "${0:\$1}"
```

# True if equal

``` shellscript
${1:\$?} -eq ${0:0}
```

# True if greater than

``` shellscript
${1:\$?} -gt ${0:0}
```

# True if less than

``` shellscript
${1:\$?} -lt ${0:0}
```

# True if empty variable

``` shellscript
-z "${${0:1}:-}"
```

# True if not empty variable

``` shellscript
-n "${${0:1}:-}"
```

# True if no args

``` shellscript
$# -eq ${0:0}
```

# True if variable matches string

``` shellscript
"$${1:1}" = "${0:string}"
```

# True if command is executable

``` shellscript
-x "$(command -v ${0:ls})"
```

# True if `uname` matches

``` shellscript
"$(uname)" = "Linux"
```

# While loop one-liner

``` shellscript
while read i; do { ${0:echo $i} } done
```

# While loop

``` shellscript
while read i; do
  ${0:echo $i}
done
```

# For loop

``` shellscript
for ${1:name} in ${2:"\$@"}; do
  echo "\$$name"
done
```

# For loop directories

``` shellscript
for dir in */; do
  echo $dir;
done
```

# For loop one-liner

``` shellscript
for i in ${1:*}; do { ${0:echo $i} } done
```

# Rename files in current directory

``` shellscript
for i in *; do { mv $i \`echo $i | tr '[A-Z]' '[a-z]' | tr ' ' '-'\` } done
```

# Exit status

``` shellscript
\$?
```

# Set IFS

``` shellscript
old_IFS=$IFS
IFS="${1: }"
IFS=${old_IFS}
```

# Script directory

``` shellscript
cd \$(dirname "\$0" || exit 1)
```

# `getopts`

``` shellscript
force="false"
while getopts ":p:fh" option; do
  case "\$option" in
    p)
      file_path="\$OPTARG"
      ;;
    f)
      force="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -\$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -\$OPTARG" >&2
      exit 1
      ;;
  esac
done
```

