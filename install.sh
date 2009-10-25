#!/bin/bash

# dot file install script.  It's written in shell script to avoid needing to
# install some other scritping language just to get this to work.

display_usage ()
{
	echo "install.sh [-f]"
	echo "  -f force operations, blowing away existing files"
	echo
}

files_exist ()
{
	local safe=1
	
	if [ -e ~/.bash ]; then
		echo ".bash already exists"
		safe=0
	fi
	
	if [ -e ~/.bash_profile ]; then
		echo ".bash_profile already exists"
		safe=0
	fi

	if [ -e ~/.bashrc ]; then
		echo ".bashrc already exists"
		safe=0
	fi
	
	if [ -e ~/.gitconfig ]; then
		echo ".gitconfig already exists"
		safe=0
	fi
	
	if [ -e ~/.gitignore ]; then
		echo ".gitignore already exists"
		safe=0
	fi
	
	if [ -e ~/.vimrc ]; then
		echo ".vimrc already exists"
		safe=0
	fi
	
	return $safe
}

echo

if [ -z $1 ]; then
	echo "Checking for existing files ..."
	echo
	if files_exist; then
		echo
		exit
	fi
	echo "Installing dot files ..."
	echo
elif [ $1 = "-f" ]; then
	echo "Destructively installing dot files ..."
	echo
else
	display_usage
	exit
fi

rm -rf ~/.bash ~/.bash_profile ~/.bashrc ~/.gitconfig ~/.gitignore ~/.vimrc

dirpath=`pwd`
uname=`uname`

ln -s $dirpath/bash ~/.bash
if [ $uname = "Linux" ]; then
	ln -s $dirpath/bash_profile.work ~/.bash_profile
else
	ln -s $dirpath/bash_profile ~/.bash_profile
fi
ln -s $dirpath/bashrc ~/.bashrc
ln -s $dirpath/gitconfig ~/.gitconfig
ln -s $dirpath/gitignore ~/.gitignore
ln -s $dirpath/vimrc ~/.vimrc

echo "Done!"
