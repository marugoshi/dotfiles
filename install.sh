#!/bin/sh

#
# Install Dotfiles
#
# usage: sh ./install.sh
#

# start
echo "Installing dotfiles..."
echo "Caution! This script must be your dotfiles. You should backup files before run this script."

# set os
echo "Type OS from below: [redhat/debian]"
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
  echo "You should type OS."
  exit 1
fi

# create symbolic link
echo "Create dotfiles symbolic files under your home directory..."

# finish
echo "Done."
