#!/bin/bash


files="bashrc zshrc oh-my-zsh gitconfig nanorc config oh-my-zsh"

for file in $files; do
    echo "Check $file"
    if [ -L ~/.$file ]; then
        echo "~/.$file is symbolic link"
    fi 
    if [ -f ~/.$file ]; then
	    echo "~/.$file is regular file"
    fi
    if [ -e ~/.$file ]; then
        echo "~/.$file something exists"
    else
        echo "~/.$file something doesn't exists"
    fi

    if [ -e ~/.$file ]; then
	    if [ ! -L ~/.$file ]; then
	        echo "~/.$file exists and it is not symbolic link"
    	fi
    fi
    # mv ~/.$file $olddir
    # echo "Creating symlink to $file in home directory."
    # ln -s $dir/$file ~/.$file
done


bin_dir=~/Projects/dotfiles/bin

for file in ${bin_dir}/*; do
	[ -e "$file" ] || continue
	echo "Bin file: $file"
	base_name="$(basename -- $file)"
	echo "Base name bin: $base_name"

	if [ -e ~/bin/${base_name} ]; then
		echo "File exists ~/bin/${base_name}"
        if [ ! -L ~/bin/${base_name} ]; then
            echo "File is not a link"
            echo "mv"
            echo "ln"
        fi
	fi
done


