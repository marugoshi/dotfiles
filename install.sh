#!/bin/sh

#
# Install Dotfiles
#
# usage: sh ./install.sh
#

# start
printf "Installing dotfiles...\n"

# set os
printf "Type OS from below: [redhat/debian]\n"
read os
case $os in
  'redhat' | 'debian')
    selected=1
    ;;
  *)
    selected=0
    ;;
esac
if [ "$selected" -eq 0 ] ; then
  printf "You should type OS.\n"
  exit 1
fi

# create symbolic link
printf "Create symbolic files under your home directory...\n"

common_files="`pwd`/common/*"
os_files="`pwd`/$os/*"
for orig_path in $common_files $os_files ; do
  target_file=".${orig_path##*/}"
  target_path="$HOME/$target_file"
  if [ -f $target_path ] ; then
    printf "$target_file is already exists in your home directory. Override?: [yN]\n"
    read flag
    case $flag in
      'y')
        rm $target_path
        ;;
      *)
        printf "skiped.\n"
        ;;
    esac
  fi
  ln -s $orig_path $target_path
done

# finish
printf "Done.\n"
