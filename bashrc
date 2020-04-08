# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

## ######################## ##
## BASH PROMPT              ##
## ######################## ##
# define colors
reset="\e[0m";
black="\e[30m"; bold_black="\e[1;30m";
red="\e[31m"; bold_red="\e[1;31m";
green="\e[32m"; bold_green="\e[1;32m";
yellow="\e[33m"; bold_yellow="\e[1;33m";
blue="\e[34m"; bold_blue="\e[1;34m";
purple="\e[35m"; bold_purple="\e[1;35m";
cyan="\e[36m"; bold_cyan="\e[1;36m";
white="\e[37m"; bold_white="\e[1;37m";

# MacOS specific.
GIT_CORE_PATH='/usr/local/etc/bash_completion.d'
[[ -x "${GIT_CORE_PATH}/git-completion.bash" ]] && source "${GIT_CORE_PATH}/git-completion.bash"
[[ -x "${GIT_CORE_PATH}/git-prompt.sh" ]] && source "${GIT_CORE_PATH}/git-prompt.sh"

if [ -n "$(type -t __git_ps1)" ] && [ "$(type -t __git_ps1)" = function ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  has_git_prompt=yes
else
  GIT_PS1_SHOWDIRTYSTATE=
  has_git_prompt=
fi

PS1="${debian_chroot:+($debian_chroot)}"
PS1+="\[${red}\]\h "
PS1+="\[${green}\]\w"
if [ -n "$has_git_prompt" ]; then
  # The use of single-quotes is mandatory.
  PS1+='$(__git_ps1) '
else
  PS1+=" "
fi
PS1+="\[${blue}\][\j]"
PS1+="\n"
PS1+="\[${bold_yellow}\]\$ \[${reset}\]"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

# forget colors
unset reset
unset black bold_black
unset red bold_red
unset green bold_green
unset yellow bold_yellow
unset blue bold_blue
unset purple bold_purple
unset cyan bold_cyan
unset white bold_white

## ######################## ##
## FUNCTIONS                ##
## ######################## ##
function diralias() {
    # determine where the aliases are
    if [ -z "${DIRALIAS}" ]; then
        export DIRALIAS="${HOME}/.diraliases"
    fi
    if [ ! -f "$DIRALIAS" ]; then
        touch "${DIRALIAS}"
    fi
    alias=
    path=
    if [[ $# == 0 ]]; then
        cat "${DIRALIAS}" | sort
        return
    elif [[ $# == 1 ]]; then
        alias=$1
    else
        alias=$1
        path=$2
    fi

    # check if aliases file already exists
    key=$(grep "^${alias}=" ${DIRALIAS})
    if [ -n "${path}" ] && [ -n "${key}" ]; then
        # replace value -- using semicolon as delim to avoid
        # conflicts with /
        sed -i.bak -r "s;(${alias}=).*;\1${path};" ${DIRALIAS}
        rm -f "${DIRALIAS}.bak"
        echo "Replaced alias '${alias}' for '${path}'"
    elif [ -n "${path}" ]; then
        # add new value
        echo "${alias}=${path}" >> ${DIRALIAS}
        echo "Added alias '${alias}' for '${path}'"
    elif [ -n "${key}" ]; then
        echo "diralias is ${key}"
    else
        echo "unknown alias ${alias}"
    fi
}

function go() {
    # validation check
    if [[ $# < 1 ]]; then
        echo "usage: diralias <alias>"
        return
    fi
    alias=$1
    # determine where the aliases are
    if [ -z "${DIRALIAS}" ]; then
        export DIRALIAS="${HOME}/.diraliases"
    fi
    # check if aliases file already exists
    keyval=
    if [ ! -f "$DIRALIAS" ]; then
        echo "unknown diralias '${alias}'"
    else
        # check if key already exists
        keyval=$(grep "^${alias}=" ${DIRALIAS} | cut -d"=" -f2)
    fi
    if [ -z ${keyval} ]; then
        echo "unknown diralias '${alias}'"
    else
        cd "${keyval}"
    fi
}

function pathappend() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
}

function pathprepend() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
}

## ######################## ##
## EXPORTS                  ##
## ######################## ##
# Add bin to path
pathprepend ~/bin

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

# Make vim the default editor.
export EDITOR='vim';

## ######################## ##
## ALIASES                  ##
## ######################## ##
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# laziness
alias md='mkdir'
alias v='vim'
alias tls='tmux list-sessions'

## ######################## ##
## MAIN                     ##
## ######################## ##

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Load the shell dotfiles, and then some:
# ~/.localrc can be used for other settings you don’t want to commit.
[ -f ~/.localrc ] && source ~/.localrc;
