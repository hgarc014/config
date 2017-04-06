export PATH=/home/henry/Software/activator-dist-1.3.10/bin/:$PATH

#alias for sshing
alias sshwell='ssh hgarc014@well.cs.ucr.edu'
#alias sshlab='ssh hgarc014@dblab-server.cs.ucr.edu'
#alias java1.8='/home/henry/Desktop/jre1.8.0_45/bin/java'
#alias cdsdf='cd ~/workspace/projects/SmartDocFinder/'
alias cdp='cd ~/workspace/projects/'
#alias sshsledge='ssh hgarc014@sledge.cs.ucr.edu'
#alias sshdragon='ssh dragonh1@107.180.21.22'
alias sshTS='ssh 557f2f374382ecfc5a000088@tweetsearcher-programhenry.rhcloud.com'
alias rm='rm -I'
alias keystop='syndaemon -i 1 -K -d'

########################
#USEFUL functions below
########################


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
# killport "port#"
#
# kill a port in use
#############################################
killport()
{
    if [ -z $1 ]; then
        echo "Usage: killport [port]"
            return 1
    else
        fuser -k $1/tcp
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


