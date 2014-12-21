#!/bin/bash

# ****IMPORTANT****
# assume config folder is in the ~ directory

dir=~/config
olddir=~/config_old
files=$(ls -I *.sh)

echo -e "creating $olddir for backup of current dotfiles in ~\n"
mkdir -p $olddir

for file in $files; do
    echo "moving .$file to $olddir"
    mv ~/.$file $olddir
    echo -e "creating ~/.$file linked to $dir/$file\n"
    ln -s $dir/$file ~/.$file
done

