# LOAD ENVIR VARIABLES
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# LOAD ALIASES
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

autoload -U colors && colors
PROMPT="%{$fg[green]%}%*%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%} %{$fg[magenta]%}[%j]%{$reset_color%} \$ "


