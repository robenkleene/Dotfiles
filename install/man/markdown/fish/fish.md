%

# fish

- `⌥↑` / `⌥.`: Insert last argument of previous command
- `⌥→`, `⌥f`: Accept part of completion
- `→`, `⌃f`: Accept full completion
- `cdh`: Visit `cd` history
- `⌃C`: Cancel current line

## Navigation

- `⌥←` / `⌥→`: Go lower / higher in directory hierarchy

## Tips

- Commands that start with a space, ` ls` will be hidden from history

## Iterate Directories

Checkout master, reset, clean dead branches.

	for directory in */
       echo "Entering $directory"
       cd $directory
       git-reset
       git checkout master
       git pull
       git-reset
       git-prune-remote-origin 
       cd ..
	end

## Process Substitution

`cat <(cat file.txt)` does not work, use `psub` instead:

    cat (cat file.txt | psub)

## Debugging

- `fish_key_reader`: Show key stroke code for bind
- `fish --profile /tmp/fish.prof -ic exit`: Profiling

## Functions

- `type my_function`: Show definition of function
    - `type my_function | bat -l fish`: In a pager with syntax highlighting
- `funced`: Define an impromptu function
