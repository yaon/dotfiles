# Options, exports and stuff {{{

autoload -U colors && colors

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.histzsh
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt histignorealldups sharehistory

setopt prompt_subst
setopt glob_dots
setopt EXTENDED_GLOB
setopt extendedglob
unsetopt no_match

unsetopt beep

setopt long_list_jobs

local prompt="vm %(?,%{$fg[green]%}%%%{$reset_color%},%{$fg[red]%}#%{$reset_color%})"
PROMPT="$prompt "
export RPROMPT=''
export PAGER='less'
export LESS="-R"
export PATH="/sbin:$PATH"
export EDITOR='vim'
export WORDCHARS=''
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LC_CTYPE=en_US.UTF-8
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# because why the fuck not here
setxkbmap us

# }}}
# {{{ completion

autoload -Uz compinit
compinit

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

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

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*' list-colors ''

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# }}}
# {{{ Keys

# Edit command line with <c-w>
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-w' edit-command-line

# Move word by word
bindkey ';5D' backward-word
bindkey ';5C' forward-word

bindkey -e
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# }}}
# {{{ Aliases

alias 5get='echo pyshell: code.interact(local=locals())'

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
alias -g L="| less" #and that (i still like you two)

alias gls='git log --stat'
alias glr='git log --raw'
alias glg='git log --graph'
alias glo='git log --pretty=oneline'
alias glp='git log -p'

alias rsync-copy="rsync -av --progress -h"
alias rsync-move="rsync -av --progress -h --remove-source-files"
alias rsync-update="rsync -avu --progress -h"
alias rsync-synchronize="rsync -avu --delete --progress -h"

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
alias MINE="sudo chown -R $USER.$USER" #1 too
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
alias nano='vim'
alias pico='vim'
alias emacs='vim'
alias gedit='vim'
alias notepad='vim'
alias world='vim'
alias notepad++='vim'
alias g='git'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias sou='source ~/.zshrc'
alias age='echo $(( $(( $( date +%s ) - $( date -d "1991-09-23" +%s ) )) / 86400 / 365))'

# (verry) advanced syntax correction
alias please='sudo'
alias wtf='dmesg'
alias nomz='ps aux'
alias nomnom='killall'
alias rtfm='man'
alias donotwant='rm'
alias dowant='cp'
alias gtfo='mv'
alias byes='exit'
alias cya='reboot'
alias kthxbai='halt'

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
function ifd { "sudo ifup $1; sudo ifdown $1" }
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
    #mencoder $1 -o $2 -oac copy -ovc lavc -lavcopts vcodec=mpeg1video -of mpeg
    mencoder -oac pcm -ovc copy -aid 1 $1 -o $1.mp4
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
# {{{ colors ?
# A script to make using 256 colors in zsh less painful.
# P.C. Shyamshankar <sykora@lucentbeing.com>
# Copied from http://github.com/sykora/etc/blob/master/zsh/functions/spectrum/

typeset -Ag FX FG BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

# }}}
#{{{ web_search
function web_search()
{
    local open_cmd
    if [[ $(uname -s) == 'Darwin' ]]; then
        open_cmd='open'
    else
        open_cmd='xdg-open'
    fi


    if [[ ! $1 =~ '(google|bing|yahoo|duckduckgo)' ]];
    then
        echo "Search engine $1 not supported."
        return 1
    fi

    local url="http://www.$1.com"


    if [[ $# -le 1 ]]; then
        $open_cmd "$url"
        return
    fi
    if [[ $1 == 'duckduckgo' ]]; then

        url="${url}/?q="
    else
        url="${url}/search?q="
    fi
    shift

    while [[ $# -gt 0 ]]; do
        url="${url}$1+"
        shift
    done

    url="${url%?}"

    $open_cmd "$url"
}


alias bing='web_search bing'
alias google='web_search google'
alias yahoo='web_search yahoo'
alias ddg='web_search duckduckgo'

alias wiki='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias youtube='web_search duckduckgo \!yt'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'
alias ducky='web_search duckduckgo \!'

#}}}
# # {{{ Colors for man
# man()
# {
#     env \
#         LESS_TERMCAP_mb=$(printf "\e[1;31m") \
#         LESS_TERMCAP_md=$(printf "\e[1;31m") \
#         LESS_TERMCAP_me=$(printf "\e[0m") \
#         LESS_TERMCAP_se=$(printf "\e[0m") \
#         LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
#         LESS_TERMCAP_ue=$(printf "\e[0m") \
#         LESS_TERMCAP_us=$(printf "\e[1;32m") \
#         man "$@"
# }
# #}}}
# {{{ how_do_i_prettyfact?
function how_do_i_prettyfact?
{
    echo ez:
    echo 'static void prettyfact(int n)'
    echo '{ if (n == 1) throw 1; try { prettyfact (n-1); } catch (int i) { throw i*n; } }'
    echo 'int fact (int n)'
    echo '{ try { prettyfact (n); } catch (int ret) { return ret; } return 0; }'
}
# }}}
# {{{ tips
function tips
{
    echo 'import code; code.interact(local = locals())'
}
# }}}
# }}}
