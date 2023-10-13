# `git` Bisect

This is a good start for finding a good commit:

* `git log master..`: list all the commits on the current branch that aren't on master

1. Start:

		git bisect start

2. Say current commit is bad:

		git bisect bad

3. Reference a known good commit:

		git bisect good 9bcdd91bacb943c638416bd7cf85b5adc6918034

4. Git will automatically perform a checkout, then:

		git bisect good
	
	Or:
	
		git bisect bad
	
	Depending if commit is good or bad

5. After finishing, to return to original state:
	
		git bisect reset
