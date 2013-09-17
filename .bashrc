# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033#[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
alias NS='killall jogsoul.pl; ~/tools/jogsoul.pl ~/tools/jogsoul.conf'
alias bcm='./bootstrap && ./configure && make'
export EDITOR='vim'
export HISTSIZE=1000
export MAIL="/u/all/${USER}/mail/${USER}"
export PAGER='less'
export PS1="\[\e[1;32m\]$ \[\e[m\]"
export tSAVEHIST=1000
export WATCH='all'

#export LD_LIBRARY_PATH="$HOME/lib:$HOME/lib/boost:$LD_LIBRARY_PATH"

alias fgcc='gcc -Wextra -Wall -std=c99 -pedantic'
alias fgpp='g++ -Wextra -Wall -std=c++0x'
alias clpp='clang++ -Wextra -Wall -std=c++0x'
alias fgccdb='gcc -Wextra -Wall -std=c99 -pedantic -g -ggdb'
alias valgrind='valgrind -v --leak-check=full --show-reachable=yes\
 --track-fds=yes --track-origins=yes --malloc-fill=42 --free-fill=43'
alias mkc='~/tools/./mkc.sh'
alias mkcc='~/tools/./mkcc.sh'
alias mkhx='~/tools/./mkhx.sh'
alias ll='ls -l'
alias la='ls -la'
alias j='jobs'
alias emacs='emacs -nw'
alias rm='rm -i'
alias gf='fg'
alias repof='sudo reboot'
alias pof='sudo poweroff'
alias pozzerio='sudo poweroff'
alias cb='cd .. && ls'
alias v='vim'
alias jim='vim'
alias bim='vim'
alias vin='vim'
alias goo='chromium-browser &'
alias g='git'
alias cdp='cd /home/'
alias cdp='cd /home/yaon/bot/'
alias suj='evince ~/dev/suj.pdf &'
alias sli='evince ~/dev/sli.pdf &'
alias caps_lock2esc='~/tools/caps_lock2esc.sh'
alias NOCAPS='~/tools/caps_lock2esc.sh'
alias esc2caps_lock='~/tools/esc2caps_lock.sh'
alias GO='java -jar ~/ludiciels/cgoban.jar &'
alias chk='~/tools/check_norme'
alias mk='make -j6 &'
alias st='git status | head -n 25'
alias mh='make 2> /tmp/mh; cat /tmp/mh | head -n 25'
alias kj='pkill jogsoul.pl'
alias kj='pkill cgoban.jnlp'
alias NG='killall jogsoul.pl ; killall java ;                           \
~/tools/jogsoul.pl ~/tools/jogsoul.conf ;                               \
java -jar ~/ludiciels/cgoban.jar &'
alias mvd='mv ~/Downloads/* ./'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias sou='source ~/.bashrc'
alias ppp='xbacklight -set 1; javaws ~/ludiciels/cgoban.jnlp &'
alias ppppp='sudo poweroff'
alias nb='/home/yaon/sft/netbeans-7.3/bin/netbeans &'
alias bc='java -jar /home/yaon/tools/BrunalChat.jar 10.41.129.7 4242 Jimal &'
alias bcnn='java -jar /home/yaon/tools/BrunalChat.jar 10.41.129.7 4242 '

function cl
{
  cd $1 && ls
}

function CLONE
{
  git clone ssh://git@git.acu.epita.fr/2015/$1/$2 $1
}

function light
{
  xbacklight -set $1
}

if [ -f ${HOME}/.mybashrc ]
then
  . ${HOME}/.mybashrc
fi
GREEN='\e[0;32m'
RED='\e[0;31m'
ESC='\e[0m'
EXIT_CODE='$(if [[ $RETURN = 0 ]]; then echo -ne ""; else echo -ne "\[$RED\]$RETURN\[$ESC\]"; fi;)'
PS1="$EXIT_CODE$GREEN♥ $ESC"
