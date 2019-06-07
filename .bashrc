# .bashrc

# Source global definitions
unset PROMPT_COMMAND
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# COLORS!
NC='\033[0m' # No Color
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT_GRAY='\033[0;37m'
DARK_GRAY='\033[1;30m'
LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHT_BLUE='\033[1;34m'
LIGHT_PURPLE='\033[1;35m'
LIGHT_CYAN='\033[1;36m'
WHITE='\033[1;37m'

git_branch() {
     git branch 2>/dev/null | grep -Po '(?<=\* ).*' 
}

color_prompt() {
    unset PROMPT_COLOR
    unset BRANCH_COLOR
    unset DATE_COLOR
    unset PATH_COLOR
    unset HOST_COLOR
    [ -f ~/.bashrc-local-pre ] && source ~/.bashrc-local-pre

    [ -z "$DATE_COLOR" ] && DATE_COLOR=$WHITE
    [ -z "$HOST_COLOR" ] && HOST_COLOR=$LIGHT_GRAY
    [ -z "$PATH_COLOR" ] && PATH_COLOR=$LIGHT_BLUE
    [ -z "$PROMPT_COLOR" ] && PROMPT_COLOR=$YELLOW
    [ -z "$MASTER_COLOR" ] && MASTER_COLOR=$RED
    [ -z "$BRANCH_COLOR" ] && BRANCH_COLOR=$PURPLE
    export PS1="\n${PROMPT_COLOR}[ ${HOST_COLOR}\u@\h ${PROMPT_COLOR}at ${DATE_COLOR}\D{%s} ${PROMPT_COLOR}in ${PATH_COLOR}\w${BRANCH_COLOR}\$(BRANCH=\$(git_branch) ; case \"\$BRANCH\" in  \"\") ;; \"master\") echo \" ${PROMPT_COLOR}on ${MASTER_COLOR}MASTER${PROMPT_COLOR}\" ;; *) echo \" ${PROMPT_COLOR}on ${BRANCH_COLOR}\$BRANCH${PROMPT_COLOR}\" ;; esac) ${PROMPT_COLOR}]\n${PROMPT_COLOR}$ ${NC}"
}

if [ "$(uname)" == "Linux" ]; then
    export PROMPT_COMMAND="xmodmap &>/dev/null || source /usr/bin/byobu-reconnect-sockets; $PROMPT_COMMAND"
fi

color_prompt

# User specific aliases and functions
export LESS="-R"
export HISTSIZE=100000
export HISTTIMEFORMAT="%F %T %s%t"
alias v='vim'

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

[ -f ~/.bashrc-local ] && source ~/.bashrc-local # for backwards compat
[ -f ~/.bashrc-local-post ] && source ~/.bashrc-local-post

# Map Caps Lock to ESC (set back to "Caps_Lock" to undo)
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# added by Anaconda2 4.4.0 installer
export PATH="/home/smibrd/local/anaconda2/bin:$PATH"
