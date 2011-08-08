#!/bin/sh

#
# Install Dotfiles
#
# usage: sh ./install.sh
#

# initialize
support_os="redhat debian osx"

# start
printf "Installing dotfiles...\n"

# set os
printf "  Type OS from below: [$support_os]\n"
read selected_os
for os in $support_os ; do
  if [ -n "$selected_os" ] ; then
    if [ $selected_os = $os ] ; then
      selected=1
    fi
  fi
done
if [ -z "$selected" ] ; then
  printf "  You should type OS.\n"
  exit 1
fi
printf "\n"

# create symbolic link
printf "  Create files under your home directory...\n"
common_files="`pwd`/common/*"
os_files="`pwd`/$selected_os/*"
for orig_file in $common_files $os_files ; do
  if [ -f $orig_file ] ; then
    orig_path=$orig_file # ex) /rc/dotfiles/common/vimrc
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

# create symolic link for vim
vim_dir="$HOME/.vim"

bundle_dir="$vim_dir/bundle"
if [ ! -d "$bundle_dir" ] ; then
  mkdir -p $bundle_dir
  printf "Create $bundle_dir...done.\n"
fi

under_vim_dirs="vundle"
for under_vim_dir in $under_vim_dirs ; do
  orig_under_vim_dir="`pwd`/common/vim/$under_vim_dir"
  target_under_vim_dir="$vim_dir/$under_vim_dir"
  # TODO: skip if symbolic link exists
  # TODO: rm if symbolic link exists
  rm $target_under_vim_dir
  ln -s $orig_under_vim_dir $target_under_vim_dir
  printf "Create Symbolic link to $target_under_vim_dir...done.\n"
done

# finish
printf "Done.\n"
