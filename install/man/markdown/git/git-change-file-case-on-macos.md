%

# git Change File Case on macOS

	mv foo foo2
	git add -A
	git commit -m "renaming"
	mv foo2 FOO
	git add -A
	git commit --amend -m "renamed foo to FOO"
