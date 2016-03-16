# LOAD ENVIR VARIABLES
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# LOAD ALIASES
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# Change PS1 to show git branch
GIT_PS1_SHOWDIRTYSTATE=true

#export PS1="\[\e[35m\]\t \[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n$ "
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\t \[\e[33m\]\w$(__git_ps1)\[\e[0m\] \[\e[35m\][\j]\[\e[0m\]\n\$ '

