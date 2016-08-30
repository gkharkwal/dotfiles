# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Load the shell dotfiles, and then some:
# ~/.localrc can be used for other settings you don’t want to commit.
for file in ~/.{functions,exports,aliases,localrc}; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add bin to path
pathprepend ~/bin

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

## ######################## ##
## BASH PROMPT              ##
## ######################## ##

if [ ! -x /usr/bin/tput ] || ! tput setaf 1 >&/dev/null; then
  # We lack color support;
  # (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  return
fi

# define colors
reset="\e[0m";
black="\e[30m"; dark_gray="\e[1;30m";
red="\e[31m"; light_red="\e[1;31m";
green="\e[32m"; light_green="\e[1;32m";
brown="\e[33m"; yellow="\e[1;33m";
blue="\e[34m"; light_blue="\e[1;34m";
purple="\e[35m"; light_purple="\e[1;35m";
cyan="\e[36m"; light_cyan="\e[1;36m";
white="\e[37m"; light_gray="\e[1;37m";

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
PS1+="\[${green}\]\h "
PS1+="\[${brown}\]\w"
if [ -n "$has_git_prompt" ]; then
  # The use of single-quotes is mandatory.
  PS1+='$(__git_ps1) '
else
  PS1+=" "
fi
PS1+="\[${purple}\][\j]"
PS1+="\n"
PS1+="\[${white}\]\$ \[${reset}\]"

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
unset black dark_gray
unset black dark_gray
unset red light_red
unset green light_green
unset brown yellow
unset blue light_blue
unset purple light_purple
unset cyan light_cyan
unset white light_gray

