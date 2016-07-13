# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{exports,functions,path,aliases,extra}; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

## ######################## ##
## BASH PROMPT              ##
## ######################## ##

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
  else
  color_prompt=
  fi
fi

# Mac specific
if [ -s /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
fi

if [ -s /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
fi

# uncomment for git prompt, if the terminal has the capability; turned off
# by default to not distract the user.
use_git_prompt=yes
if [ -n "$use_git_prompt" ]; then
  if [ -n "$(type -t __git_ps1)" ] && [ "$(type -t __git_ps1)" = function ]; then
  # check if git prompt can actually be shown
    GIT_PS1_SHOWDIRTYSTATE=true
    use_git_prompt=yes
  else
    use_git_prompt=
  fi
fi

# Guide:
#   \[\e]0;\w\a\] - This sets the window title to match the current working
#           directory, and use an alert. The \[ and \] denote non-printing
#           characters to avoid line counting issues.
#
# CAUTION: new line in PS1 can cause issues with __git_ps1, use at own risk.
if [ "$color_prompt" = yes ]; then
  if [ "$use_git_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[32m\]\h \[\e[33m\]\W$(__git_ps1)\[\e[0m\] \[\e[35m\][\j]\[\e[0m\] \$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\e[32m\]\h \[\e[33m\]\W\[\e[0m\] \[\e[35m\][\j]\[\e[0m\] \$ '
  fi
else
  if [ "$use_git_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\h \W$(__git_ps1) [\j] \$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\h \W [\j] \$ '
  fi
fi
unset color_prompt force_color_prompt use_git_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac
