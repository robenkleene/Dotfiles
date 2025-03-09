# Template

``` bash
#!/usr/bin/env bash

set -euo pipefail
```

# `cd` Script Directory

``` bash
cd "$(dirname "$0")" || exit 1
```

# Check Platform

``` bash
if [[ "$(uname)" == "Linux" ]]; then
```
