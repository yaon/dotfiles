autoload -U colors && colors

setopt histignorealldups sharehistory
setopt prompt_subst
setopt glob_dots
setopt EXTENDED_GLOB
setopt extendedglob
unsetopt beep #beep!

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

# because why the fuck not here
setxkbmap us

# Exports
local prompt="%(?,%{$fg[green]%}%%%{$reset_color%},%{$fg[red]%}#%{$reset_color%})"
PROMPT="$prompt "
export RPROMPT=''
export PAGER='less'
export PATH="/sbin:$PATH"
export EDITOR='vim'
export WORDCHARS=''

# {{{ Aliases
## univ
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias bcm='./bootstrap && ./configure && make'
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
alias -g NF='*(.om[1])' # newest file
alias lsL='ls -hlS **/*(.Lm+2)  | less' # list largest files  largest first  *N*
#alias -g G="| grep" #fuck this
#alias -g L="| less" #and that

alias gls='git log --stat'
alias glr='git log --raw'
alias glg='git log --graph'
alias glo='git log --pretty=oneline'
alias glp='git log -p'

# essencial
alias repof='sudo reboot'
alias pof='sudo poweroff'
alias pozzerio='sudo poweroff'
function cl { cd $1 && ls }
function light { xbacklight -set $1 }
function sagi { sudo apt-get -y install $1 } #1
alias mkc='~/tools/./mkc.sh'
alias mkcc='~/tools/./mkcc.sh'
function mkcd() { mkdir -p $1; cd $1 }
alias mkhx='~/tools/./mkhx.sh'
alias kj='killall java'
alias goo='chromium-browser &'
alias kgs='javaws http://files.gokgs.com/javaBin/cgoban.jnlp'
alias zr='vim ~/.zshrc'
alias vr='vim ~/.vimrc'

#dompter le tigre
alias mk='make -j4 &'
alias st='git status | head -n 25'
alias mh='make -j4 2> /tmp/mh; cat /tmp/mh | head -n 25'

## advanced syntax correction
alias gf='fg'
alias v='vim'
alias jim='vim'
alias bim='vim'
alias vin='vim'
alias g='git'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias sou='source ~/.zshrc'

#stage
alias -g SC="~/script/"
alias -g PR="~/php/"
alias cdp='cd /home/vide/php'
alias cds='cd /home/vide/script'
alias cdd='cd ~/Downloads'
alias debugApache='sudo tail -f /var/log/apache2/error.log'
alias uploadToServ='cd ~/php; scp -r ^.* 192.168.1.2:/var/www/'

# home
alias cda='cd /home/yaon/aureole'
alias py='python3.2'

alias suj='evince ~/dev/suj.pdf &'
alias sli='evince ~/dev/sli.pdf &'
alias shit='ls -shit'
# }}}
