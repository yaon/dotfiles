autoload -U colors && colors

setopt histignorealldups sharehistory
setopt prompt_subst
setopt glob_dots
setopt EXTENDED_GLOB
setopt extendedglob
unsetopt beep #beep!
unsetopt no_match #should make apt-get globbing work

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
# control arrow
bindkey ';5D' backward-word
bindkey ';5C' forward-word

# why would you just keep 1000
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.histzsh

# {{{ completion

autoload -Uz compinit
compinit

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/chewie/.zshrc'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
eval "$(dircolors -b)"
zstyle ':completion:*' use-compctl false
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# }}}

# Exports
local prompt="vm %(?,%{$fg[green]%}%%%{$reset_color%},%{$fg[red]%}#%{$reset_color%})"
PROMPT="$prompt "
export RPROMPT=''
export PAGER='less'
export PATH="/sbin:$PATH"
export EDITOR='vim'
export WORDCHARS=''
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'

# {{{ Aliases

# because why the fuck not here
setxkbmap us
## univ
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias valgrind='valgrind -v --leak-check=full --show-reachable=yes\
 --track-fds=yes --track-origins=yes --malloc-fill=42 --free-fill=43'
alias ll='ls -l'
alias la='ls -la'
alias j='jobs'
alias emacs='emacs -nw'
alias rm='rm -i' # dem safety
alias cb='cd .. && ls'
alias mvd='mv ~/Downloads/* ./'
alias lsn='ls -lt  **/*(.om[1,20])' # list 20 newest files
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --" # copy with progress bar
alias lsh='ls *(.)' # ls hidden files
alias lsf='ls *~*.*(.)' # ls files
alias lsd='ls -d */' # ls folder
alias -g ND='*(/om[1])' # newest directory
alias -g NF='*(.om[1])' # newest file FIXME: allways .histfile ...
alias lsL='ls -hlS **/*(.Lm+2)  | less' # list largest files  largest first  *N*
alias -g G="| grep" #fuck this
alias -g L="| less" #and that

alias gls='git log --stat'
alias glr='git log --raw'
alias glg='git log --graph'
alias glo='git log --pretty=oneline'
alias glp='git log -p'

# essencial
alias repof='sudo reboot'
alias pof='sudo poweroff'
alias pozzerio='sudo poweroff'
function cl { cd $1 && ls } #kinda disgusting
function mkcd() { mkdir -p $1; cd $1 }
function light { xbacklight -set $1 }
function sagi { sudo apt-get -y install $1 } #1
alias kj='killall java'
alias goo='chromium-browser &'
alias kgs='javaws http://files.gokgs.com/javaBin/cgoban.jnlp'
alias zr='vim ~/.zshrc'
alias vr='vim ~/.vimrc'
alias MINE='sudo chown -R yaon' #1 too
alias pig='ping google.com'
manopt(){ man $1 |sed 's/.\x08//g'|sed -n "/^\s\+-\+$2\b/,/^\s*$/p"|sed '$d;';} 
alias reconfig='kill -s USR2 `xprop -root _BLACKBOX_PID | awk '"'"'{print $3}'"'"'`'
cpspd() {rsync --bwlimit=200 src dest} # Do an rsync and limit the bandwidth used to about 200KB/sec.
#vvar() {OIFS=$IFS;IFS=$'\n';vim $( grep -l '$fill' *.pl );IFS=$OIFS} # Edit the set of files that contain the variable $somevar.

#dompter le tigre
alias bcm='./bootstrap && ./configure && make -j4'
alias cm='./configure && make -j4'
alias mk='make -j4 &'
alias st='git status | head -n 25'
alias mh='make -j4 2> /tmp/mh; cat /tmp/mh | head -n 25'

## advanced syntax correction
alias gf='fg'
alias sv='sudo vim'
alias v='vim'
alias jim='vim'
alias bim='vim'
alias vin='vim'
alias g='git'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias sou='source ~/.zshrc'
alias age='echo $(( $(( $( date +%s ) - $( date -d "1991-09-23" +%s ) )) / 86400 / 365))'
# {{{ pig
rainbow(){ for i in {1..7}; do tput setaf $i; echo $@; tput sgr0; done; }
lucky(){ awk -varg=^$1 '$0~arg' .histzsh | shuf | head -1; }
factorial(){ seq -s* $1 -1 ${2:-1} | bc; }
dolphin () { for t in {1..7} ;do for i in _ . - '*' - . _ _ _ ;do echo -ne "\b\b__${i}_";sleep 0.20;done;done; }
randomcd(){ d=$(find / -maxdepth 1 -type d \( -path '/root' -prune -o -print \) | shuf | head -1); cd "$d"; } # randomcd is random.
am_i_right(){ echo yes; true; }
amarite(){ echo yes; true; }
ttest1() {while :;do t=($(date +"%l %M %P")); [[ "${t[1]}" == 0 ]] && echo "${t[0]} ${t[2]}" |(espeak||say); sleep 1m; done} # Speak the hour
# }}}

# stage
alias -g SC="~/script/"
alias -g PR="~/php/"
alias cdp='cd /home/yaon/vide'
alias cds='cd /home/vide/script'
alias cdd='cd ~/Downloads'
alias debugApache='sudo tail -f /var/log/apache2/error.log'
alias dbApache='sudo scp 192.168.1.2:/var/log/apache2 /tmp/; less /tmp/apache2'
alias uploadToServ='cd ~/vide; scp -r ^.* vide@192.168.1.2:/var/www/'
alias -g P1='vide@192.168.1.2'
alias -g P2='vide@192.168.1.3'
alias -g P3='vide@192.168.1.4'
alias -g MP='vide@192.168.1.23'
alias -g MS='vide@192.168.1.100'

# mine
alias cda='cd /home/yaon/aureole'
alias suj='evince ~/dev/suj.pdf &'
alias sli='evince ~/dev/sli.pdf &'
alias -g PI='pi@192.168.0.46'

# python
alias py='python3.2'
alias tree='tree -I __pycache__'

#cool
alias shit='ls -shit'
alias tmux="TERM=screen-256color-bce tmux"
# }}}
# {{{ no scripts aloud
# {{{ ttv
function ttv
{
    sshpass -p ediv scp -r /var/www/py/toggleTv.py vide@192.168.1.2:/var/www/py/
    sshpass -p ediv ssh vide@192.168.1.2 "/var/www/py/toggleTv.py $1 $2"
}
# }}}
# {{{ piwall
function piwall
{
    if [ $# -eq 0 ]; then
        pwomxplayer udp://239.0.1.23:1234?buffer_size=1200000B
    else
        pwomxplayer --tile-code=$1 udp://239.0.1.23:1234?buffer_size=1200000B
    fi
}
# }}}
# {{{ piwall_master video
function piwall_master
{
    while true; do
        avconv -re -i $1 -vcodec copy -an -f avi udp://239.0.1.23:1234
    done
}
# }}}
# {{{ piEncode in out
function piEncode
{
    mencoder $1 -o $2 -oac copy -ovc lavc -lavcopts vcodec=mpeg1video -of mpeg
}
# }}}
# {{{ mkc
function mkc
{
    touch $1.c
    touch $1.h

    chmod 640 $1.c
    chmod 640 $1.h

    CAPS=`echo $1 | tr [a-z] [A-Z]`

    echo "#ifndef $CAPS"_H_ >> $1.h
    echo "# define $CAPS"_H_ >> $1.h
    echo >> $1.h
    echo >> $1.h
    echo >> $1.h
    echo "#endif /* !$CAPS""_H_ */" >> $1.h
    echo "#include \"$1.h\"" >> $1.c
} # }}}
#{{{ mkcc
function mkcc
{
    touch $1.cc
    touch $1.hh

    chmod 640 $1.cc
    chmod 640 $1.hh

    CAPS=`echo $1 | tr [a-z-] [A-Z_]`
    #Class=`echo ${1:0:1} | tr [a-z] [A-Z]`
    echo "#ifndef $CAPS"_HH_ >> $1.hh
    echo "# define $CAPS"_HH_ >> $1.hh
    echo >> $1.hh
    echo >> $1.hh
    echo >> $1.hh
    echo "#endif /* !$CAPS""_HH_ */" >> $1.hh

    echo "#include \"$1.hh\"" >> $1.cc
} #}}}
# {{{ mkhx
function mkhx
{
    touch $1.hxx
    touch $1.hh

    chmod 640 $1.hxx
    chmod 640 $1.hh

    CAPS=`echo $1 | tr [a-z-] [A-Z_]`

    echo "#ifndef $CAPS"_HH_ >> $1.hh
    echo "# define $CAPS"_HH_ >> $1.hh
    echo >> $1.hh
    echo >> $1.hh
    echo >> $1.hh
    echo "# include \"$1.hxx\"" >> $1.hh
    echo "#endif /* !$CAPS""_HH_ */" >> $1.hh


    echo "#ifndef $CAPS"_HXX_ >> $1.hxx
    echo "# define $CAPS"_HXX_ >> $1.hxx
    echo "# include \"$1.hh\"" >> $1.hxx
    echo >> $1.hxx
    echo >> $1.hxx
    echo >> $1.hxx
    echo "#endif /* !$CAPS""_HXX_ */" >> $1.hxx
} # }}}
# {{{ PIencode file
function PIencode
{
    mencoder -oac pcm -ovc copy -aid 1 $1 -o $1.mp4
} # }}}
# {{{ gify (Mov to Gif)
gify() {
  if [[ -n "$1" && -n "$2" ]]; then
    ffmpeg -i $1 -pix_fmt rgb24 temp.gif
    convert -layers Optimize temp.gif $2
    rm temp.gif
  else
    echo "proper usage: gify <input_movie.mov> <output_file.gif>. You DO need to include extensions."
  fi
} # }}}
# }}}

## mv Picture{,-of-my-cat}.jpg

# MEMO
echo jeudi test technique RDC 17 heures
