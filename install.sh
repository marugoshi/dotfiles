#!/bin/sh

#
# Install Dotfiles
#
# usage: sh ./install.sh
#

# initialize
support_os="redhat debian"

# start
printf "Installing dotfiles...\n"

# set os
printf "Type OS from below: [$support_os]\n"
read selected_os
for os in $support_os ; do
  if [ -n "$selected_os" ] ; then
    if [ $selected_os = $os ] ; then
      selected=1
    fi
  fi
done
if [ -z "$selected" ] ; then
  printf "You should type OS.\n"
  exit 1
fi

# create symbolic link
printf "Create symbolic files under your home directory...\n"

common_files="`pwd`/common/*"
os_files="`pwd`/$selected_os/*"
for orig_path in $common_files $os_files ; do
  target_file=".${orig_path##*/}"
  target_path="$HOME/$target_file"
  if [ -f $target_path ] ; then
    printf "$target_file is already exists in your home directory. Override?: [yN]\n"
    read flag
    case $flag in
      'y')
        rm $target_path
        ln -s $orig_path $target_path
        ;;
      *)
        printf "skiped.\n"
        ;;
    esac
  else
    ln -s $orig_path $target_path
  fi
done

# finish
printf "Done.\n"
