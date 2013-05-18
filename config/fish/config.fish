set PATH ~/Development/Scripts/bin $PATH

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

function fish_prompt
	set_color $fish_color_cwd
	echo -n (prompt_pwd)
	set_color normal
	echo -n '> '
end

function fish_right_prompt
	echo -n (__fish_git_prompt)
end

function egitn
    set --local EGITNEXT (egit -n)
	if test -n $EGITNEXT
		echo $EGITNEXT
		echo "test"
		cd $EGITNEXT
		git status
	end
end