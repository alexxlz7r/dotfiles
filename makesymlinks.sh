#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dotfiles_dir=~/Projects/dotfiles

dir=~/Projects/dotfiles                    # dotfiles directory
olddir=~/Projects/dotfiles_old             # old dotfiles backup directory
files="bashrc zshrc oh-my-zsh gitconfig tmux.conf"    # list of files/folders to symlink in homedir

bin_dir=$dotfiles_dir/bin

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    if [ -e ~/.$file ]; then
	    if [ ! -L ~/.$file ]; then
	        echo "Moving any existing dotfiles from ~ to $olddir"
    	    mv ~/.$file $olddir
            echo "Creating symlink to $file in home directory."
            ln -s $dir/$file ~/.$file
	    else 
	        echo "File ~/.$file is a symlink" 
	    fi
    else
    	echo "File ~/.$file doesn't exist"
	    echo "Creating symlink to $file in home directory."
     	ln -s $dir/$file ~/.$file
    fi
done

for file in ${bin_dir}/*; do
    [ -e "$file" ] || continue
    echo "Bin dir file $file"
done


install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git
    fi

    if [[ ! -d $dir/oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    if [[ ! -d $dir/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi

    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            sudo yum install zsh
            install_zsh
        fi
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install zsh
            install_zsh
        fi
	if [[ -f /etc/manjaro-release ]]; then
	    sudo pamac install zsh
	    install_zsh
	fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh


cmd_tools="fzf fd bat eza"

for tool in $cmd_tools; do
    echo "Check if $tool is installed"
    if [ -f /bin/$tool -o -f /usr/bin/$tool ]; then
        echo "$tool is already installed"
    else
        echo "Installing $tool"
        sudo pacman -Sy --noconfirm $tool
    fi
done


#echo "Check if fzf is installed"
#if [ -f /bin/fzf -o -f /usr/bin/fzf ]; then
#    echo "fzf is already installed"
#else
#    echo "Installing fzf"
#    sudo pacman -Sy --noconfirm fzf
#fi

#echo "Check if fd is installed"
#if [ -f /bin/fd -o -f /usr/bin/fd ]; then
#    echo "fd is already installed"
#else 
#    echo "Installing fd"
#    sudo pacman -Sy --noconfirm fd
#fi

#echo "Check if bat is installed"
#if [ -f /bin/bat -o -f /usr/bin/bat ]; then
#    echo "bat is already installed"
#else 
#    echo "Installing bat"
#    sudo pacman -Sy --noconfirm bat
#fi

#echo "Check if eza is installed"
#if [ -f /bin/eza -o -f /usr/bin/eza ]; then
#    echo "eza is already installed"
#else 
#    echo "Installing eza"
#    sudo pacman -Sy --noconfirm eza
#fi



