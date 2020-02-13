#!/bin/bash

debug_flag=false
single_flag=false

usage () {
  echo -e "-d \tto turn on debugging\
  \n-s <file> \tto add a single file\
  \n-h \tfor help";
}

options=':dhs:'
while getopts $options option
do
    case "$option" in
        d  ) debug_flag=true;;
        s  ) single_flag=true;single_value=$OPTARG;;
        h  ) usage; exit;;
        \? ) echo "Unknown option: -$OPTARG" >&2; exit 1;;
        :  ) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
        *  ) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
    esac
done

cmd(){
  cmd="$1"
  if [ "$debug_flag" = true ]; then
    echo "DEBUG: $cmd"
  fi
  eval "$cmd"
}

#moves old file to backup file if exists
#then creates a link to config folder
addFile(){
    file="$1"

    echo "creating link for $file"
    if [ -e "$HOME/.$file" ] || [ -h "$HOME/.$file" ] ;then
        cmd "mv "$HOME/.$file" "$olddir""
    fi

    cmd "ln -s "$dir/$file" "$HOME/.$file""
}


###
###
############ Main ##########
###
###



#Path to config file
dir=$(pwd)
#Path to backup file
olddir=$HOME/old_dotfiles
#files in current directory ignoring .sh (mac does not have this functionality)
#files=$(ls -I *.sh)
files=$(find . -maxdepth 1 ! -path "*sh" ! -path "*.md" -type f -exec basename {} \;)

echo -e "backing up files to: $olddir\n"
cmd "mkdir -p $olddir"

for file in $files; do
    if [ "$single_flag" = "false" ] || [ "$file" == "$single_value" ]; then
      addFile "$file"
    fi
done
