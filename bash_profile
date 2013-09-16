# set default editor
export EDITOR=/usr/bin/vim
export NODE_PATH=/usr/local/lib/node/

# customize history
# HISTCONTROL can be one of 'ignoredups' 'ignorespace' 'ignoreboth' 'erasedups'
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTIGNORE=exit:ls

# color options
export CLICOLOR=1
export LSCOLORS='gxfxcxdxbxegedabagacad'
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'

# load any aliases that may be defined
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Android tools
export ANDROID_HOME=/Users/hchoi/dev/android-sdk-macosx
export PATH=${PATH}:${ANDROID_HOME}/tools

function prompt_command {
  local fillsize
  local cut

  PS_PWD="${PWD/$HOME/~}"
  local promptsize=$(echo -n "[${USER}@$(hostname -s) 00:00:00] " | wc -c | tr -d " ")
  local rvmsize=$(~/.rvm/bin/rvm-prompt | sed -e "s/ruby-//" | sed -e "s/-p/#/" | wc -c | tr -d " ")
  let fillsize=${COLUMNS}-${promptsize}-${rvmsize}-2
  PS_FILL=""
  while [ "$fillsize" -gt "0" ]; do
    PS_FILL="${PS_FILL}―"
    let fillsize=${fillsize}-1
  done

  if [ "$fillsize" -lt "0" ]; then
    let cut=3-${fillsize}
    PS_PWD="...$(echo -n $PS_PWD | sed -e "s/\(^.\{$cut\}\)\(.*\)/\2/")"
  fi
}

PROMPT_COMMAND=prompt_command

source ~/.bash_profile_git
function termwide {
  case $TERM in
    xterm*)
      TITLEBAR='\[\033]0;\w\007\]'
      ;;
    *)
      TITLEBAR=""
      ;;
  esac

  GITPS='$(git_info)'

  RVMPS='$(~/.rvm/bin/rvm-prompt | sed -e "s/ruby-//" | sed -e "s/-p/#/")'

  local     RESET="\[\033[0m\]"
  local  BG_RESET="\[\033[40m\]"
  local BG_YELLOW="\[\033[45m\]"
  local   BG_GRAY="\[\033[47m\]"
  local      GRAY="\[\033[0;30m\]"
  local       RED="\[\033[1;31m\]"
  local     GREEN="\[\033[1;32m\]"
  local    YELLOW="\[\033[1;33m\]"
  local      BLUE="\[\033[1;34m\]"
  local      PINK="\[\033[1;35m\]"
  local      CYAN="\[\033[1;36m\]"
  local      GRAY="\[\033[1;37m\]"

  local color="RED"
  PS1="$TITLEBAR\
$YELLOW[\u@\h \
$GRAY$PINK($RVMPS)\
$YELLOW \${PS_FILL} \t]\n\
$CYAN$GITPS\
$GREEN[\${PS_PWD}]\
$RESET \$ "
  PS2=">$RESET "
}

# RVM - Ruby Version Manager
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

source ~/.git-completion.bash
# git completion
source "$rvm_path/contrib/ps1_functions"
termwide

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

fortune | cowsay
