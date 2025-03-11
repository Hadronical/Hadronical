# ALIASES
#=========
	# cd
	alias ..="CD .."
	alias coding="CD ~/Desktop/Other/Coding"
	alias latex="CD ~/Documents/Latex"
	
	# listing
	alias list="eza --icons --classify --color=always"
	alias ld="list -lDh --no-time --no-user --no-filesize"
	alias lf="list -f"
	alias ls="list --group-directories-first"
	alias sl="ls"
	alias la="ls -a"
	alias lt="list -T --level=2"

	# open directory in Finder
	alias openf="open -a Finder /"
	
	# http requests
	alias http="xh -v --pretty all"
	alias httpbody="xh -b"
	
	# date
	alias date="date +\"%a|%d/%m/%Y || %R\""
	
	# vim to neovim
	alias vim="nvim"
	
	# interactive (safer) mv
	alias smv="mv -ivn"
	
	# interactive (safer) cp
	alias scp="cp -r -i"
	
	# interactive (safer) rm
	alias srm="rm -i"

# OTHER FUNCs
#============
mk () {
	mkdir -pv $1;
	ls
}
trsh () {
	read -p "move $1 to TRASH? [y/n] " yesno
	case $yesno in
		[Yy]* ) mv -i $1 ~/.Trash; echo "moved $1 to TRASH";;
		[Nn]* ) echo "cancelled";;
	esac
}

CD () {
	cd $1;
	ls;
}

lv () {
	local divider1
	local divider2
	divider1=$(printf '<%*s' 12 | tr ' ' '=')
	divider2=$(printf '%*s>' 12 | tr ' ' '=')
	echo $divider1 "Directories" $divider2
	ld;
	echo ""
	echo $divider1 "Files" $divider2
	lf -lhB --no-user --no-time;
}

slct () {
	FILES=$(find . -maxdepth 1 -type f | sed 's/..//')
	 
	PS3="Select a file/directory [NUM(ENTER)]: "
	select SLCT in $FILES; do
		echo "$SLCT";
		break;
	done
}

writable () {
	if [ -w $1 ]; then
		echo "$1 iS WRITABLE";
	else
		echo "$1 IS NOT WRITABLE";
	fi
}

# COMPILING C++
#===============
cppcomp () {
	c++ $1 -o "${1%.*}" -std=c++17 -Wall;
}
cpprun () {
	cppcomp $1; ./"${1%.*}" & fg;
	echo "program out: $?";
}

# COMPILING C
#===============
ccomp () {
	clang $1 -o "${1%.*}" -Wall;
}
crun () {
	ccomp $1; ./"${1%.*}" & fg;
	echo "program out: $?";
}

# COMPILING JAVA
runj () {
	javac $1
	java 
}

# COMPILING RUST
rscomp () {
	rustc $1 -o "${1%.*}"
}
rsrun () {
	rscomp $1; ./"${1%.*}" & fg;
	echo "program out: $?";
}

. "$HOME/.cargo/env"
