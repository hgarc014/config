#!/bin/bash

IS_DEBUG=false
IS_SINGLE_FILE=false

usage () {
  echo -e "-d \tto turn on debugging\
  \n-s <file> \tto add a single file\
  \n-h \tfor help";
}

options=':dhs:'
while getopts $options option
do
    case "$option" in
        d  ) IS_DEBUG=true;;
        s  ) IS_SINGLE_FILE=true;SINGLE_FILE_VALUE=$OPTARG;;
        h  ) usage; exit;;
        \? ) echo "Unknown option: -$OPTARG" >&2; exit 1;;
        :  ) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
        *  ) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
    esac
done


cmd(){
  cmd="$1"
  if [ "$IS_DEBUG" = true ]; then
    echo "DEBUG: $cmd"
  fi
  eval "$cmd"
}

#moves old file to backup file if exists
#then creates a link to config folder
addFile(){
    file="$1"
    homePath="$2"
    newDotPath="$3"
    oldDotPath="$4"

    echo "creating link for $file"
    # -e file exists, -h file exists and is symbolic link
    if [ -e "$homePath/.$file" ] || [ -h "$homePath/.$file" ] ;then
        cmd "mv \"$homePath/.$file\" \"$oldDotPath\""
    fi

    cmd "ln -s \"$newDotPath/$file\" \"$homePath/.$file\""
}


###
###
############ Main ##########
###
###

DEFAULT_FILES=("bash_aliases" "profile" "vimrc" "gitconfig" "zshrc" "zprofile")

DOT_FOLDER_NAME="dotfiles"
OLD_DOT_FOLDER_NAME="old_dotfiles"
SCRIPT_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DOT_FILES_PATH="$SCRIPT_LOCATION/$DOT_FOLDER_NAME"
OLD_DOT_FILES_PATH="$SCRIPT_LOCATION/$OLD_DOT_FOLDER_NAME"
HOME_PATH="$HOME"


# # TODO: can make use of this to determine OS
# case "$OSTYPE" in
#   solaris*) echo "SOLARIS" ;;
#   darwin*)  echo "OSX" ;;
#   linux*)   echo "LINUX" ;;
#   bsd*)     echo "BSD" ;;
#   msys*)    echo "WINDOWS" ;;
#   *)        echo "unknown: $OSTYPE" ;;
# esac

# list all files in the dot file location
#files=$(ls -I *.sh) # this is for linux, mac does not have this functionality
files=$(find $DOT_FILES_PATH -maxdepth 1 ! -path "*sh" ! -path "*.md" -type f -exec basename {} \;)

if [ -z "$files" ]; then
  echo "$DOT_FILES_PATH is empty backing up default: \"${DEFAULT_FILES[@]}\" "
  files="${DEFAULT_FILES[@]}"
  # Overwrite OLD_DOT_FILESPATH to DOT_FILES_PATH as we want to save the file instead of
  # moving it to the old file Path
  OLD_DOT_FILES_PATH="$DOT_FILES_PATH"
fi

cmd "mkdir -p $DOT_FILES_PATH"

echo -e "backing up files to: $OLD_DOT_FILES_PATH\n"
cmd "mkdir -p $OLD_DOT_FILES_PATH"


for file in $files; do
    if [ "$IS_SINGLE_FILE" = "false" ] || [ "$file" == "$SINGLE_FILE_VALUE" ]; then
      addFile "$file" "$HOME_PATH" "$DOT_FILES_PATH" "$OLD_DOT_FILES_PATH"
    fi
done
