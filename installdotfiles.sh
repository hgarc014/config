#!/bin/bash


#Path to config file
dir=$HOME/config
#Path to backup file
olddir=$HOME/config_old
#files in current directory
files=$(ls -I *.sh)

#moves old file to backup file if exists
#then creates a link to config folder
addFile(){
    file="$1"
    if [ -e "$HOME/.$file" ] || [ -h "$HOME/.$file" ] ;then
        echo "moving current $HOME/.$file to $olddir"
        mv "$HOME/.$file" "$olddir"
    else
        echo "current $HOME/.$file didn't exist"
    fi

    echo -e "creating $HOME/.$file linked to $dir/$file\n"
    ln -s "$dir/$file" "$HOME/.$file"
}

echo -e "creating $olddir for backup of current dotfiles in $HOME\n"
mkdir -p $olddir

for file in $files; do
    addFile "$file"
done

