# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

export PS1="\[$(tput setaf 2)\][\u:\w]\\$\[$(tput sgr0)\] "
export PS2="$(tput setaf 2)>$(tput sgr0) "
export PROMPT_COMMAND="printf \"\\033]0;%s@%s:%s\\007\" \"\${USER}\" \"\${HOSTNAME##*.}\" \"\${PWD/#\$HOME/\\~}\""
export EDITOR=$(which vim)
#alias python=python3
#alias music=mocp
#if [ -z $COLUMNS ] ; then
#  fortune -ac | cowsay -W 78 -e oO
#else
#  fortune -ac | cowsay -W $(($COLUMNS-4)) -e oO
#fi
#echo ""
#~/.local/share/emptyTrash.sh
