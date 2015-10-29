
#alias for sshing
alias sshwell='ssh hgarc014@well.cs.ucr.edu'
alias sshlab='ssh hgarc014@dblab-server.cs.ucr.edu'
alias java1.8='/home/henry/Desktop/jre1.8.0_45/bin/java'
#alias cdsdf='cd ~/workspace/projects/SmartDocFinder/'
alias cdp='cd ~/workspace/projects/'
alias sshsledge='ssh hgarc014@sledge.cs.ucr.edu'
alias sshdragon='ssh dragonh1@107.180.21.22'
alias sshTS='ssh 557f2f374382ecfc5a000088@tweetsearcher-programhenry.rhcloud.com'
alias csmysql='mysql --user=mwile001 --password=d3143 -h 127.0.0.1 --port=3333'
alias rm='rm -I'

#USEFUL functions

#allow going back up to a previous folder in current path
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

#allows going down to a folder (can be slow)
jd(){
    if [ -z "$1" ]; then
        echo "Usage: jd [directory]";
    return 1
    else
        cd **"/$1"
            fi
}
shopt -s globstar

#view markdown file in terminal 
md()
{
    if [ -z $1 ];then
        echo "Usage: md [file]"
            return 1
    else
        pandoc -s -f markdown -t man $1 | man -l -
            fi
}

#killport given port number
killport()
{
    if [ -z $1 ]; then
        echo "Usage: killport [port]"
            return 1
    else
        fuser -k $1/tcp
            fi
}


