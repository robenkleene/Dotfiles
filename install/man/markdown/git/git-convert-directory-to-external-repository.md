%

# `git` Convert to External Repository

Useful for convert a single folder to a submodule or a Frameworks while preserving history.

	# Startout with a fresh checkout:
	git clone git@github.com:robenkleene/webconsole.git XCTestTemp

	# cd to directory
	# Checkout relevant branch if it's not the default
	
	# Extract a specific directory:
	git filter-branch --prune-empty --subdirectory-filter Web\ Console/XCTestTemp master
	
	# Clean up unnecessary data
	git reflog expire --expire=now --all
	git repack -ad
	git prune
	
	# Detach from origin
	git remote remove origin
	
	# Delete all tags
	git tag | xargs git tag -d
	
	# Rename the branch to master
	git branch --move master

To really clean up the repository:

	rm -rf .git/refs/original/ .git/refs/remotes/ .git/*_HEAD .git/logs/
	git for-each-ref --format="%(refname)" refs/original/ | xargs -n1 git update-ref -d
	git -c gc.reflogExpire=0 -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0  -c gc.rerereunresolved=0 -c gc.pruneExpire=now gc "$@"

Use this command to confirm only what you want is in the resultant repository:

	git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | awk '/^blob/ {print substr($0,6)}' | sort --numeric-sort --key=2
