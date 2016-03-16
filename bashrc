# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# LOAD ENVIR VARIABLES {{{
if [ -f ~/.profile ]; then
    . ~/.profile
fi
# }}}

# LOAD ALIASES {{{
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
# }}}

# HISTORY {{{
# Reset size of history
export HISTSIZE=50000
export HISTFILESIZE=50000

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups:erasedups

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
# }}}


# CUSTOM PROMPT {{{
# Guide:
#   \[\e]0;\w\a\] - This sets the window title to match the current working
#                   directory, and use an alert. The \[ and \] denote non-printing
#                   characters to avoid line counting issues.
#
# CAUTION: new line in PS1 can cause issues with __git_ps1, use at own risk.

USE_GIT_PROMPT=false
if [ "$USE_GIT_PROMPT" = true ] && [ -n "$(type -t __git_ps1)" ] && [ "$(type -t __git_ps1)" = function ]; then
    GIT_PS1_SHOWDIRTYSTATE=true
    export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\t \[\e[33m\]\w$(__git_ps1)\[\e[0m\] \[\e[35m\][\j]\[\e[0m\] \[\e[1;36m\]\$\[\e[0m\] '
else
    export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\h \[\e[33m\]\w\[\e[0m\] \[\e[35m\][\j]\[\e[0m\] \[\e[1;36m\]\$\[\e[0m\] '
fi

# }}}
