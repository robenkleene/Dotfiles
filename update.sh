#!/bin/sh

git submodule foreach git pull origin master

# Not quite sure how to fix this situation yet:
# 1. When a submodule gets updated, git that shows directory as dirty.
# 2. I think I just want add and commit those changes, git isn't really updated files in the submodule. The change is to reflect the submodules status.
# 3. But then the submodule's git will be shown as being ahead of master (why?), e.g., as if I had local changes I hadn't pushed to the remote repo.
# 4. Running git fetch origin on that repo appears to fix the issue as described here:
# [Why do I have to push the changes I just pulled from origin in Git? - Stack Overflow](http://stackoverflow.com/questions/5283829/why-do-i-have-to-push-the-changes-i-just-pulled-from-origin-in-git)
git submodule foreach git fetch origin
# git submodule update
