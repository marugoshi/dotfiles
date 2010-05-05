if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f /rc/bash_minimum ]; then
    . /rc/bash_minimum
fi

if [ -f /rc/bash_debian ]; then
    . /rc/bash_debian
fi
