# On OSX, git may be installed via MacPorts.  If so, source the .profile file first so that the git completion script works better.
if [ -f ~/.profile ]; then
	source ~/.profile
fi

source ~/.bash/git_completion.bash

PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
