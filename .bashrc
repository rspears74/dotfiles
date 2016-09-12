#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.local/bin:$PATH"


alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

function _update_ps1() {
	    PS1="$(~/.powerline-shell/powerline-shell.py $? 2> /dev/null)"
    }

if [ "$TERM" != "linux" ]; then
	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/bin/virtualenvwrapper.sh
