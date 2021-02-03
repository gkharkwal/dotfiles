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
alias ..="cd .."
alias ...="cd ../.."
alias md='mkdir'
alias v='vim'
alias tls='tmux list-sessions'

## --------
# Functions
## --------
function tmx () {
  tmux new -A -s ${1:-default}
}

## ----------
# Shortcuts
## ----------
bindkey "^[[A" history-beginning-search-backward
bindkey "^P" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^N" history-beginning-search-forward

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
# Git autocompletions
## -------
autoload -Uz compinit && compinit

## -------
# Git prompt
## --------
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:git:*' formats '%b%u%c '
zstyle ':vcs_info:git:*' actionformats '%a%u%c '

## -------
# Prompt
## -------
NEWLINE=$'\n'
PROMPT="%F{green}%m%f %F{yellow}%~%f %F{blue}\$vcs_info_msg_0_%f %F{magenta}[%j]%f${NEWLINE}%# "

## -------
# Localrc
## -------
[ -f ~/.localrc ] && source ~/.localrc
