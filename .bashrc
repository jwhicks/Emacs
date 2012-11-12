# User dependent .bashrc file
#==============================================================================
# Miscellaneous configurations
#==============================================================================
set HOST=`uname -n` DEVTTY=`tty`
#limit coredumpsize 0

# Set backspace to use the backspace key instead of the delete key
stty erase ^h
# Allows filename completion
set filec


#=============================================================================
#=          ALIASES
#=============================================================================
#
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
 alias psa='ps -aef |grep john'
# alias ls='ls -hF --color=tty'                 # classify files in colour
 alias ls='ls -hF --color=auto'                 # classify files in colour
 alias ll='ls -l'                              # long list
 alias lsa='ls -a'                             # all
 alias lsA='ls -A'                             # all but . and ..
 alias df='df -h'
 alias du='du -h'
 alias dir='ls --color=auto --format=vertical'
 alias vdir='ls --color=auto --format=long'
 alias lsd='ls -lrt |grep ^d --color=auto'     # list directories
 alias lsl='ls -lrt |grep ^l --color=auto'     # list symbolic links
 alias lst='ls -lrt *.txt*'
 alias lsp='ls -lrt *.p*'
 alias lsh='ls -lrt *.h*'
 alias lsj='ls -lrt *.java*'
 alias lsx='ls -lrt *.xml*'
 alias clean='rm *~'
 alias clean2='rm .*~'
 alias view='/usr/bin/xemacs'

#===============================================================
# path
#===============================================================
PATH=.
PATH=$PATH:/bin
PATH=$PATH:/sbin
PATH=$PATH:/usr/sbin
PATH=$PATH:/usr/bin

#===============================================================
# Clean up Bash Shell in Emacs
#===============================================================
#export PS1='address@hidden $DISPLAY \W]$ '
#export PS1='john $DISPLAY \w]$ '
export PS1='\u@\W]$'

#JAVA_HOME=C:\Program Files (x86)\Java\jdk1.6.0_30

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle () 
# { 
#   echo -ne "\e]2;$@\a\e]1;$@\a"; 
# }
# 

alarm() {
  perl -e '
    eval {
      $SIG{ALRM} = sub { die };
      alarm shift;
      system(@ARGV);
    };
    if ($@) { exit 1 }
  ' "$@";
}

scan() {
  if [[ -z $1 || -z $2 ]]; then
    echo "Usage: $0 <host> <port, ports, or port-range>"
    return
  fi

  local host=$1
  local ports=()
  case $2 in
    *-*)
      IFS=- read start end <<< "$2"
      for ((port=start; port <= end; port++)); do
        ports+=($port)
      done
      ;;
    *,*)
      IFS=, read -ra ports <<< "$2"
      ;;
    *)
      ports+=($2)
      ;;
  esac


  for port in "${ports[@]}"; do
    alarm 1 "echo >/dev/tcp/$host/$port &&
      echo \"port $port is open\"" ||
      echo "port $port is closed"
  done
}
