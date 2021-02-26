# dotfiles
backup of configuration files

running `installdotfiles.sh` will do 1 of the following:

1. if there are files specified on the `dotfiles` folder
    * then it will move all files in the home directory from the `dotfiles` folder into the backup folder `old_dotfiles` Then it will create a symbolic link of the file in `dotfiles` to your home directory.
2. If there are no files specified in `dotfiles` folder
    * then it will attempt to store dot files defined in `DEFAULT_FILES` into the `dotfiles` folder. Then it will create a symbolic link of the file in `dotfiles` to your home directory.

you can also select individual dotfiles to backup by making use of the -s flag.

`./installdotfiles.sh -s <fileName>`

can also make use of the -h flag to get help on the commands
