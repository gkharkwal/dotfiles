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

# git
alias g='git'
alias gb='git branch'
alias gs='git status'
alias gf='git fetch --all'
alias gd='git diff'
alias gl='git log --abbrev-commit --graph'

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
bindkey '^H' backward-kill-word

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

zstyle ':vcs_info:*' enable git
# Checking for all changes is slower but without it
# we cannot track unstaged changes.
zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:git:*' formats '%F{blue}[%b]%f%u%c'
zstyle ':vcs_info:git:*' actionformats '%F{blue}[%b|%a]%f%u%c'

## -------
# Prompt
## -------
# requires `brew install kube_ps1`
# source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
NEWLINE=$'\n'
PROMPT="%F{green}%m%f %F{yellow}%~%f "
PROMPT+='${vcs_info_msg_0_} '
# PROMPT+='$(kube_ps1) '
PROMPT+="%F{magenta}[%j]%f${NEWLINE}%# "

## -------
# Localrc
## -------
[ -f ~/.localrc ] && source ~/.localrc
