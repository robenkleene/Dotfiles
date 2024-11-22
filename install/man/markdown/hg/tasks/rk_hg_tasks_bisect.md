# `hg` Tasks Bisect

1. Store a patch with any setup for your test, e.g., `a=$(hg show <rev>)`
2. `hg bisect --reset`
3. For a bad diff, run `hg bisect --bad`
4. Find a good diff, e.g.
    1. Find a revision with `hg log -r 'last(::. & not date(-7))'`
    2. `hg update <rev>`
    3. Apply the test patch `echo $a | patch`
    4. If the revision is good, mark it with `hg bisect --good`

