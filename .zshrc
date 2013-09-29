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
alias mkc='~/tools/./mkc.sh'
alias mkcc='~/tools/./mkcc.sh'
alias mkhx='~/tools/./mkhx.sh'
alias kj='killall java'
alias goo='chromium-browser &'
alias kgs='javaws http://files.gokgs.com/javaBin/cgoban.jnlp'
alias zr='vim ~/.zshrc'
alias vr='vim ~/.vimrc'
function MINE { sudo chown -R $USER $1; } #1 too

#dompter le tigre
alias bcm='./bootstrap && ./configure && make -j4'
alias cm='./configure && make -j4'
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

# stage
alias -g SC="~/script/"
alias -g PR="~/php/"
alias cdp='cd /home/yaon/vide'
alias cds='cd /home/vide/script'
alias cdd='cd ~/Downloads'
alias debugApache='sudo tail -f /var/log/apache2/error.log'
alias uploadToServ='cd ~/vide; scp -r ^.* vide@192.168.1.2:/var/www/'
alias -g P1='vide@192.168.1.2'
alias -g P2='vide@192.168.1.3'
alias -g P3='vide@192.168.1.4'
alias -g MP='vide@192.168.1.23'

# mine
alias cda='cd /home/yaon/aureole'
alias py='python3.2'
alias suj='evince ~/dev/suj.pdf &'
alias sli='evince ~/dev/sli.pdf &'

#cool
alias shit='ls -shit'
# }}}
