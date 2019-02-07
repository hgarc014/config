# bash aliases and functions

#############################################
# deletes all local branches except for master
#############################################
alias gbr='git branch | grep -v "master" | xargs git branch -D'

#############################################
# undos last git commit
#############################################
alias gitundo='git reset HEAD~'

#############################################
# search history commands
#############################################
alias h='history | grep '


#############################################
# upto "FOLDER"
#
# has autocomplete goes to previous folder in current path
#############################################
upto ()
{
    if [ -z "$1" ]; then
        return
            fi
            local upto=$1
            cd "${PWD/\/$upto\/*//$upto}"
}
_upto()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local d=${PWD//\//\ }
    COMPREPLY=( $( compgen -W "$d" -- "$cur" ) )
}
complete -F _upto upto

#############################################
# jd "FOLDER"
#
# jump down to a folder (can be slow) 
#
# * requires bash with globstar
#############################################
jd(){
    if [ -z "$1" ]; then
        echo "Usage: jd [directory]";
    return 1
    else
        cd **"/$1"
            fi
}
shopt -s globstar

#############################################
# md "file"
#
# view a markdown file in terminal
#
# * Requires pandoc to be installed
#############################################
md()
{
    if [ -z $1 ];then
        echo "Usage: md [file]"
            return 1
    else
        pandoc -s -f markdown -t man $1 | man -l -
            fi
}

#############################################
# switchGitRemote 
#
# swaps git from https to ssh and vise versa 
#############################################

switchGitRemote()
{
    current=$(git remote -v | head -1)
    httpurl="https://github.com/"
    sshurl="git@github.com:"
    if [[ "$current" == *"git@github.com:"* ]]; then
        #echo "current had git@github.com:"
        res=$(echo "$current" | cut -d' ' -f1 | cut -d':' -f2)
        git remote set-url origin $httpurl$res
        echo -e "converted\n $current\n to \n$httpurl$res"
    elif [[ "$current" == *"https://github.com/"* ]]; then
        #echo "current had https://github.com"
        user=$(echo "$current" | cut -d'/' -f4)
        res=$(echo "$current" | cut -d' ' -f1 | cut -d'/' -f5 )
        res="$user/$res"
        git remote set-url origin $sshurl$res
        echo -e "converted\n $current\n to \n$sshurl$res"
    fi

}


