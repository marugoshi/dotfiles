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

global_dirs="common $selected_os"

# create directories
printf "  Create directories in your home directory...\n"
for global_dir in $global_dirs ; do
  for top_dir in `ls -l ./$global_dir | awk '$1 ~ /d/ { print $NF }'` ; do
    if [ -d "./$global_dir/$top_dir" ] ; then
      for orig_path in `find ./$global_dir/$top_dir` ; do
        if [ -f $orig_path ] ; then
          tmp_dir_path=`echo $orig_path | sed -e "s/.\/"$global_dir"\///"`
          target_dir_path="$HOME/.$tmp_dir_path"
          create_dir="${target_dir_path%/*}"
          if [ ! -d $create_dir ] ; then
            printf "    Create $create_dir...done\n"
            mkdir -p $create_dir
          else
            printf "    $create_dir is already exists in your home directory. skipped.\n"
          fi
        fi
      done
    fi
  done
done
printf "  done.\n"
printf "\n"

# create symbolic link
printf "  Create files under your home directory...\n"
common_files="`pwd`/common/*"
os_files="`pwd`/$selected_os/*"
for orig_file in $common_files $os_files ; do
  if [ -d $orig_file ] ; then
    for orig_sub_dir_file in `find $orig_file` ; do
      if [ -f $orig_sub_dir_file ] ; then
        tmp_path=`echo $orig_sub_dir_file | sed -e "s/\/rc\/dotfiles\/common\///" -e "s/\/rc\/dotfiles\/$selected_os\///"`
        orig_path=$orig_sub_dir_file # ex) /rc/dotfiles/common/vim/ftplugin/ruby.vim
        target_file=".$tmp_path" # ex) ruby.vim or .vim/ftplugin/ruby.vim
        target_path="$HOME/.$tmp_path" # ex) /Users/tokuyama/.vim/ftplugin/ruby.vim

        if [ -f $target_path ] ; then
          printf "    $target_file is already exists in your home directory. Override?: [yn]\n"
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
          printf "    Copy $target_file or create symbolic link?: [cs]\n"
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
  fi

  if [ -f $orig_file ] ; then
    orig_path=$orig_file # ex) /rc/dotfiles/common/vimrc
    target_file=".${orig_path##*/}" # ex) .vimrc
    target_path="$HOME/$target_file" # ex) /Users/tokuyama/.vimrc

    if [ -f $target_path ] ; then
      printf "    $target_file is already exists in your home directory. Override?: [yn]\n"
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
      printf "    Copy $target_file or create symbolic link?: [cs]\n"
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
