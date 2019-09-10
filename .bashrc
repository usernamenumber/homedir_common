# .bashrc

[ -f ~/.bashrc-local-pre ] && source ~/.bashrc-local-pre # for backwards compat

# Source global definitions
unset PROMPT_COMMAND
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# COLORS!
NC='\[\033[0m\]' # No Color
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
ORANGE='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
LIGHT_GRAY='\[\033[0;37m\]'
DARK_GRAY='\[\033[1;30m\]'
LIGHT_RED='\[\033[1;31m\]'
LIGHT_GREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
LIGHT_BLUE='\[\033[1;34m\]'
LIGHT_PURPLE='\[\033[1;35m\]'
LIGHT_CYAN='\[\033[1;36m\]'
WHITE='\[\033[1;37m\]'

start_ssh_agent() {
    # SSH Agent
    # https://yashagarwal.in/posts/2017/12/setting-up-ssh-agent-in-i3/
    if [ -f ~/.ssh/agent.env ] ; then
        . ~/.ssh/agent.env > /dev/null
        if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
            echo "Stale agent file found. Spawning new agent… "
            eval `ssh-agent | tee ~/.ssh/agent.env`
            ssh-add
        fi
    else
        echo "Starting ssh-agent"
        eval `ssh-agent | tee ~/.ssh/agent.env`
        ssh-add
    fi
}

git_branch() {
     git branch 2>/dev/null | grep -Po '(?<=\* ).*' 
}

len() {
	echo $1 | wc -c
}
set_prompt() {
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


	USER_PART="${HOST_COLOR}\u@\h${PROMPT_COLOR}"
	DATE_PART="${DATE_COLOR}\D{%s}${PROMPT_COLOR}"

	DIR="$($HOME/.local/repos/sysadmisc/shorten_path.py)"
    DIR_PART=" ${PATH_COLOR}${DIR}${PROMPT_COLOR}"
	BRANCH=$(git_branch)
	case "$BRANCH" in  
		"") 
			BRANCH_PART=""
		;; 
		"master") 
			BRANCH_PART=" on ${MASTER_COLOR}MASTER${PROMPT_COLOR}" 
		;; 
		*) 
			BRANCH_PART=" on ${BRANCH_COLOR}\$BRANCH${PROMPT_COLOR}"
		;; 
	esac 

	PROMPT_LEN=$[ 22 + $(len $USER) + $(len $HOSTNAME) + $(len $DIR) + $(len $BRANCH)]
    PS1="\n${PROMPT_COLOR}["
	# Omit this stuff for small windows like tmux splits
	if [ "$COLUMNS" -ge "$PROMPT_LEN" ] ; then
		PS1="${PS1} ${USER_PART}"
		PS1="${PS1} at ${DATE_PART}"
		PS1="${PS1} in"
	fi 
	PS1="${PS1}${DIR_PART}"
	PS1="${PS1}${BRANCH_PART}"
	PS1="${PS1} ]\n${PROMPT_COLOR}$ ${NC}"
	export PS1
}
export PROMPT_COMMAND="set_prompt"

if [ "$(uname)" == "Linux" ]; then
    start_ssh_agent
    #export PROMPT_COMMAND="$PROMPT_COMMAND; xmodmap &>/dev/null || source /usr/bin/byobu-reconnect-sockets; $PROMPT_COMMAND"
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
    alias route="ip route"
    alias netstat="echo 'use \`ss\` you may need different options than '"
fi

set_prompt

export LESS="-R"
export HISTSIZE=100000
export HISTTIMEFORMAT="%F %T %s%t"
# Enable history appending instead of overwriting.
shopt -s histappend

alias route="ip route"
alias netstat="echo 'use \`ss\` you may need different options than '"
alias c="code -r"
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias b='bundle'
alias be='bundle exec'
alias br='bundle exec rake'
alias brr='bundle exec rake route'
alias free='free -h'
alias more=less
alias v=vim
alias g=git
alias d=docker
alias y=yarn
alias yi='yarn install'
alias yr='yarn run'
alias yrs='yarn run start'
alias kcp='kubectl --context=production'
alias kcs='kubectl --context=staging'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias vpp='vpn prod'
alias vps='vpn staging'
alias ezk='docker run --rm -v "$HOME/.aws:/root/.aws:ro" -v "$HOME/.kube:/root/.kube" -v "$(pwd)/service.yml:/usr/src/gem/service.yml:ro" -it ezcater-production.jfrog.io/ezk-gem ezk'
alias k='kubectl'
alias r='bundle exec rails'
alias rg='bundle exec rails generate'
alias rc='bundle exec rails console'
alias b='bundle'
alias be='bundle exec'
alias bi='bundle install'
alias br='bundle exec rake'


# Map Caps Lock to ESC (set back to "Caps_Lock" to undo)
[ -n "$DISPLAY" ] && xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# Local PATH extensions
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/install/bin:$PATH"
export PATH="/snap/bin:$PATH"

# added by Anaconda2 4.4.0 installer
export PATH="/home/smibrd/local/anaconda2/bin:$PATH"

[ -f ~/.bashrc-local-post ] && source ~/.bashrc-local-post

# Make thinkpad touchpad only do left-click
# https://unix.stackexchange.com/questions/438725/disabling-middle-click-on-bottom-of-a-clickpad-touchpad#438800
TOUCHPAD_ID=$(which xinput &>/dev/null && xinput | grep -o 'Elan Touchpad[[:space:]*id=[0-9]\+' | cut -d= -f2)
if [ -n "$TOUCHPAD_ID" ] ; then
    xinput set-button-map 13 1 1 1 4 5 6 7 8 9 10 11 12
fi
