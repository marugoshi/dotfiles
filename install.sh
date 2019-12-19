#!/bin/sh

#
# Install Dotfiles
#
# usage: sh ./install.sh
#

# initialize
support_os="redhat debian osx"
support_sh="bash zsh"

# start
printf "Installing dotfiles...\n"

# set os
printf "  Type OS from below: [$support_os]\n"
read selected_os
for os in $support_os ; do
  if [ -n "$selected_os" ] ; then
    if [ $selected_os = $os ] ; then
      selected_os_flg=1
    fi
  fi
done
if [ -z "$selected_os_flg" ] ; then
  printf "  You should type OS.\n"
  exit 1
fi
printf "\n"

# set sh
printf "  Type sh from below: [$support_sh]\n"
read selected_sh
for sh in $support_sh ; do
  if [ -n "$selected_sh" ] ; then
    if [ $selected_sh = $sh ] ; then
      selected_sh_flg=1
    fi
  fi
done
if [ -z "$selected_sh_flg" ] ; then
  printf "  You should type sh.\n"
  exit 1
fi
printf "\n"

# create symbolic link
printf "  Create files under your home directory...\n"
common_files="`pwd`/common/*"
sh_common_files="`pwd`/$selected_sh/common/*"
sh_os_files="`pwd`/$selected_sh/$selected_os/*"
for orig_file in $common_files $sh_common_files $sh_os_files ; do
  if [ -f $orig_file ] ; then
    orig_path=$orig_file # ex) /rc/dotfiles/zsh/common/vimrc
    target_file=".${orig_path##*/}" # ex) .vimrc
    target_path="$HOME/$target_file" # ex) /Users/tokuyama/.vimrc

    if [ -f $target_path ] ; then
      printf "    $target_file is already exists. Override?: [yn]\n"
      read flag
      case $flag in
        'y')
          rm $target_path
          printf "      Copy file or create symbolic link?: [cs]\n"
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
          printf "    skiped.\n"
          ;;
      esac
    else
      printf "    Copy $target_file or create symbolic link to $target_file?: [cs]\n"
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
  fi
done

# finish
printf "Done.\n"
