#!/bin/bash
# Inspired by https://github.com/mathiasbynens/dotfiles

cwd=$PWD
dir=$(dirname $BASH_SOURCE)

# Maintaining an explicit list for safety and sanity
files="vimrc vim bashrc zshrc"

function copyDotfiles() {
    echo "Moving to {$dir}"
    cd $dir

    for file in $files; do
    if [[ -d $file ]]; then 
        rsync -avh --no-perms $file/ ~/.$file
    else
        rsync -avh --no-perms $file ~/.$file
    fi 
    done

    echo "Moving to {$cwd}"
    cd $cwd
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
    copyDotfiles;
else
    read -p "This will overwrite files in your home directory. \
Do you want to continue? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        copyDotfiles;
    fi;
fi;

