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
    printf "$target_file is already exists in your home directory. Override?: [yn]\n"
    read flag
    case $flag in
      'y')
        rm $target_path
        printf "Copy file or create symbolic link?: [cs]\n"
        read type
        case $type in
          'c')
            cp $orig_path $target_path
            ;;
          's')
            ln -s $orig_path $target_path
            ;;
        esac
        ;;
      *)
        printf "skiped.\n"
        ;;
    esac
  else
    printf "Copy file or create symbolic link?: [cs]\n"
    read type
    case $type in
      'c')
        cp $orig_path $target_path
        ;;
      's')
        ln -s $orig_path $target_path
        ;;
    esac
  fi
done

# finish
printf "Done.\n"
