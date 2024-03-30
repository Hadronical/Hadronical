source ~/.bash_prompt
source ~/.bashrc

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
export BASH_SILENCE_DEPRECATION_WARNING=1


# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"

export CPATH="/usr/local/include"
. "$HOME/.cargo/env"
