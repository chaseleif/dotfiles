
umask 006
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
