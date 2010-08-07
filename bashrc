if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f "$HOME/.bash_minimum" ]; then
    . "$HOME/.bash_minimum"
fi

if [ -f "$HOME/.bash_debian" ]; then
    . "$HOME/.bash_debian"
fi