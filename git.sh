########################################################################################################################
# Find Us                                                                                                              #
# Author: Mehmet ÖĞMEN                                                                                                 #
# Web   : https://x-shell.codes/scripts/git                                                                            #
# Email : mailto:git.script@x-shell.codes                                                                              #
# GitHub: https://github.com/x-shell-codes/git                                                                         #
########################################################################################################################
# Contact The Developer:                                                                                               #
# https://www.mehmetogmen.com.tr - mailto:www@mehmetogmen.com.tr                                                       #
########################################################################################################################

########################################################################################################################
# Constants                                                                                                            #
########################################################################################################################
NORMAL_LINE=$(tput sgr0)
RED_LINE=$(tput setaf 1)
YELLOW_LINE=$(tput setaf 3)
GREEN_LINE=$(tput setaf 2)
BLUE_LINE=$(tput setaf 4)
POWDER_BLUE_LINE=$(tput setaf 153)
BRIGHT_LINE=$(tput bold)
REVERSE_LINE=$(tput smso)
UNDER_LINE=$(tput smul)

########################################################################################################################
# Line Helper Functions                                                                                                #
########################################################################################################################
function ErrorLine() {
  echo "${RED_LINE}$1${NORMAL_LINE}"
}

function WarningLine() {
  echo "${YELLOW_LINE}$1${NORMAL_LINE}"
}

function SuccessLine() {
  echo "${GREEN_LINE}$1${NORMAL_LINE}"
}

function InfoLine() {
  echo "${BLUE_LINE}$1${NORMAL_LINE}"
}

########################################################################################################################
# Version                                                                                                              #
########################################################################################################################
function Version() {
  echo "git install script version 1.0.0"
  echo
  echo "${BRIGHT_LINE}${UNDER_LINE}Find Us${NORMAL}"
  echo "${BRIGHT_LINE}Author${NORMAL}: Mehmet ÖĞMEN"
  echo "${BRIGHT_LINE}Web${NORMAL}   : https://x-shell.codes/scripts/git"
  echo "${BRIGHT_LINE}Email${NORMAL} : mailto:git.script@x-shell.codes"
  echo "${BRIGHT_LINE}GitHub${NORMAL}: https://github.com/x-shell-codes/git"
}

########################################################################################################################
# Help                                                                                                                 #
########################################################################################################################
function Help() {
  echo "MySQL install & configuration script."
  echo
  echo "Options:"
  echo "-u | --user        Git global config user name."
  echo "-e | --email       Git global config user email."
  echo "-h | --help        Display this help."
  echo "-V | --version     Print software version and exit."
  echo
  echo "For more details see https://github.com/x-shell-codes/git."
}

########################################################################################################################
# Arguments Parsing                                                                                                    #
########################################################################################################################
for i in "$@"; do
  case $i in
  -u=* | --user=*)
    user="${i#*=}"
    shift
    ;;
  -e=* | --email=*)
    email="${i#*=}"
    shift
    ;;
  -V | --version)
    Version
    exit
    ;;
  -* | --*)
    ErrorLine "Unexpected option: $1"
    echo
    echo "Help:"
    Help
    exit
    ;;
  esac
done

########################################################################################################################
# CheckRootUser Function                                                                                               #
########################################################################################################################
function CheckRootUser() {
  if [ "$(whoami)" != root ]; then
    ErrorLine "You need to run the script as user root or add sudo before command."
    exit 1
  fi
}

########################################################################################################################
# Main Program                                                                                                         #
########################################################################################################################
echo "${POWDER_BLUE_LINE}${BRIGHT_LINE}${REVERSE_LINE}GIT INSTALLATION${NORMAL_LINE}"

CheckRootUser

export DEBIAN_FRONTEND=noninteractive

apt update

apt install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y --force-yes git

if [ ! -z "$user" ]; then
  git config --global user.name "$user"
fi

if [ ! -z "$email" ]; then
  git config --global user.email "$email"
fi

SuccessLine "Git installation is completed."
