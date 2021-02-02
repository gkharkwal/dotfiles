# Turn off all beeps
unsetopt BEEP

## --------
# Exports
## --------
PATH=~/bin:$PATH

## --------
# Aliases
## --------
alias ls='ls -GF --color=auto'
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# laziness
alias md='mkdir'
alias v='vim'
alias tls='tmux list-sessions'

## ----------
# Shortcuts
## ----------
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

## ---------
# History
## ---------
# More storage
HISTSIZE=100000
HISTFILESIZE=100000
HISTFILE=~/.zhistory

# Ignore dups
setopt HIST_IGNORE_ALL_DUPS

# Share history
setopt inc_append_history
setopt share_history

## -------
# Prompt
## -------
NEWLINE=$'\n'
PROMPT="%F{green}%m%f %F{yellow}%~%f %F{magenta}[%j]%f${NEWLINE}%# "

## -------
# Localrc
## -------
[ -f ~/.localrc ] && source ~/.localrc
