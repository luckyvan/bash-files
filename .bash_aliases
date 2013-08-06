#############
# git #
############
alias gc='git commit -v -a'
alias gb='git branch -v'
alias st='git status -sb'
alias gd='git diff'
alias gdh='git diff HEAD --'

function gco {
	if [ $# -eq 0 ]; then
		git checkout master
	else
		git checkout "$@"
	fi
}




########
# misc #
########
#
alias cdd='cd /mnt/Development/Games/Game-001RN5'
alias cdw='cd /mnt/log/1308'

GAME_PREFIX="/mnt/Development/Games/Game-00"

# calculate game workspace directory based on:
#    1. current directory
#    2. game id
function dg {
	if [ $# -eq 0 ]; then
		echo "No Input"
		return
	fi

	if [ "$PWD" != "$(pwd | grep "$GAME_PREFIX")" ]; then
		echo "${GAME_PREFIX}$1"
		return
	fi

	PREFIX=$(pwd | sed "s/Game-00.*/Game-00/")
	POSTFIX=$(pwd | sed "s/.*Game-00[^\/]*//")

	echo "${PREFIX}$1${POSTFIX}"
	return
}

# calculate game workspace directory based on:
#    1. game id
#    2. target directory
#    3. current directory (implicit)
function vdiff {
	if [ $# -ne 2 ]; then
		echo "Invalid Input $#"
		return
	fi

	if [ "$PWD" != "$(pwd | grep "$GAME_PREFIX")" ]; then
		echo "Invalid PWD"
		return
	fi

	TARGET_DIR=$(dg "$1")
	cmd="vimdiff ${TARGET_DIR}/$2 $2"
	echo "$cmd"
	eval "$cmd"
}

# cd to game workspace based on:
#   1. current dir.
#   2. game id provided.
function cdg {
#Precondition1
	if [ $# -eq 0 ]; then
		cdd	
		return
	fi
	
#Precondition2, should already cd to a dir with GAME_PREFIX
	if [ "$PWD" != "$(pwd | grep "$GAME_PREFIX")" ]; then
		cdd
	fi

	NEW_PATH=$(dg "$1")

	echo "$NEW_PATH"

	if [ -d "$NEW_PATH" ]; then
		cd $NEW_PATH
	else
		echo "Invalid Input"
	fi
}
