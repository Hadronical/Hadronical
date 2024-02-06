# ALIASES
#=========
	# cd
	alias ..="cd ..; ls"
	alias code="cd ~/Desktop/Other/Coding"
	alias gogo="cd ~/go"
	
	# ls
	alias sl="ls"
	alias ls="ls -CF"
	alias lsa="ls -a"
	
	# mkdir
	alias mkdir="mkdir -pv"
	
	# date
	alias date="date +\"%a|%d/%m/%Y || %R\""
	
	# files
	alias fcnt="find . -maxdepth 1 -type f | wc -l"
	

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

vimsel () {
	local FILE=$(slct)
	if [[ -f "${FILE}" ]]; then
		vim $FILE;
	elif [[ $((SLCT)) != $SLCT ]]; then
		echo "unexpected input";
	fi
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
