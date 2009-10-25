#!/bin/bash

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
	
	if [ -e ~/.gitconfig ]; then
		echo ".gitconfig already exists"
		safe=0
	fi
	
	if [ -e ~/.gitignore ]; then
		echo ".gitignore already exists"
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

rm -rf ~/.bash ~/.bash_profile ~/.gitconfig ~/.gitignore

dirpath=`pwd`

ln -s $dirpath/bash ~/.bash
ln -s $dirpath/bash_profile ~/.bash_profile
ln -s $dirpath/gitconfig ~/.gitconfig
ln -s $dirpath/gitignore ~/.gitignore

echo "Done!"