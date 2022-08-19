# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make VIM the global editor
export VISUAL=vim
export EDITOR="$VISUAL"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (assumes that anything connected that supports x-term can support color...)
case "$TERM" in
    xterm*) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

set_bash_prompt()
{
    # If this is an xterm set the title to user (dir)
    case "$TERM" in
        xterm*|rxvt*)
            echo -ne "\033]0;${USER} ( ${PWD} )\007"
            ;;
        *)
            ;;
    esac

    if [[ -f "/usr/lib/git-core/git-sh-prompt" ]]
    then
        source /usr/lib/git-core/git-sh-prompt
    fi

    if [ "$color_prompt" = yes ]; then
        RESET='\[\e[0m\]'
        C11='\[\e[1;32m\]'
        C13='\[\e[1;34m\]'
        export GIT_PS1_SHOWCOLORHINTS=1
        if [ "$(which task)" ] ; then
            PS1="$(task +in +PENDING count) ${debian_chroot:+($debian_chroot)}$C11\u@\h$RESET $C13\w$RESET$(__git_ps1 ' (%s)')$RESET\$ "
        else
            PS1="${debian_chroot:+($debian_chroot)}$C11\u@\h$RESET $C13\w$RESET$(__git_ps1 ' (%s)')$RESET\$ "
        fi
    else
        if [ "$(which task)" ] ; then
            PS1="$(task +in +PENDING count) ${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 ':(%s)')\$ "
        else
            PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 ':(%s)')\$ "
        fi
    fi
}

# This tells bash to reinterpret PS1 after every command, which we need because
# __git_ps1 could be outputting color codes
PROMPT_COMMAND=set_bash_prompt


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# List aliases
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'
alias ldr='ls --color --group-directories-first'
alias ldl='ls --color -l --group-directories-first'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Color Definitions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
black='\e[0;30m'
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
blue='\e[0;34m'
purple='\e[0;35m'
cyan='\e[0;36m'
light_grey='\e[0;37m'
dark_grey='\e[1;30m'
light_red='\e[1;31m'
light_green='\e[1;32m'
orange='\e[1;33m'
light_blue='\e[1;34m'
light_purple='\e[1;35m'
light_cyan='\e[1;36m'
white='\e[1;37m'
# Return color to normal formatting
NC='\e[0m'
