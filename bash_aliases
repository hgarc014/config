# bash aliases and functions

#############################################
############### BASH ALIASES ################
#############################################

# deletes all local branches except for master
alias gbr='git branch | grep -v "master" | xargs git branch -D'

# undos last git commit
alias gitundo='git reset HEAD~'

# search history commands
alias h='history | grep '

# colored ls command
alias ls='ls -G '


#############################################
############# ALIAS FUNCTIONS  ##############
#############################################

