 [ -z "$PS1" ] && return

set -o vi

#aliases
alias ls='ls -G'
alias gs='git status'
alias gcv='git commit --verbose'
alias ll='ls -l'
alias la='ls -a'
alias dir='ls'
alias gsd='git svn dcommit'
alias gsr='git svn rebase'
alias gcv='git commit --verbose'
alias gd='git diff --no-prefix'
alias tpj='tp -j'
alias findfile='find . -iname'
alias mysql='mysql5'

export GIT_PS1_SHOWDIRTYSTATE=1

parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
  }
   
  PS1='\[\033[01;37m\]\w\[\033[00;35m\]$(parse_git_branch)\[\033[00m\] \$ '

#change the prompt
setPrompt() {
    #local GREEN_FG="\[\033[32m\]"
    #local DEFAULT_FG="\033[39m\]"
    local GREEN_FG="$(tput setaf 2)"
    local DEFAULT_FG="$(tput sgr0)"
    local BLUE_FG="$(tput setaf 4)"
    local YELLOW_FG="$(tput setaf 3)"
    PS1="${BLUE_FG}\w${DEFAULT_FG}\[\033[00;35m\]\$(parse_git_branch)\[\033[00m\]\n[${GREEN_FG}\u${DEFAULT_FG}@${GREEN_FG}\h${DEFAULT_FG}${YELLOW_FG}\${DEFAULT_FG}]\n> "
}
setPrompt

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
export TERM=xterm-color
#change locale to sv_FI.utf8
#ignore same inputs in history
export HISTCONTROL="ignoreboth"
#add my dir of handy scripts to path
export HISTIGNORE="cd:exit:pwd:hostname:"
export JAVA_HOME=/usr/lib/jvm/java-6-sun
export JAVA_HOME=/Library/Java/Home
export SVN_EDITOR=vim
export ANT_HOME=/Users/twikstro/Tools/ant
PATH=$ANT_HOME/bin:$PATH:~/scripts:~/.gem/ruby/1.8/bin:/opt/local/bin:$HOME/Tools/bin
export PATH

# source the right rvm function creation script based on rvm being installed system-wide or user-wide
if [[ -s /usr/local/lib/rvm ]]; then
    source /usr/local/lib/rvm
elif [[ -s $HOME/.rvm/scripts/rvm ]]; then
    source $HOME/.rvm/scripts/rvm
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.


export JAVA_OPTS="-Xmx4048M -Xms2024M -XX:PermSize=512M -XX:MaxPermSize=1024M"
export ANT_OPTS="-Xmx4048M -Xms2024M -XX:PermSize=512M -XX:MaxPermSize=1024M"

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export LANG=en_US
alias ssh-add='ssh-add -t 38600'

# Write bash history in realtime
shopt -s histappend
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND" 


export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Git autocompletion
source /usr/local/git/contrib/completion/git-completion.bash

# Git is fairly picky about locale
alias git='LC_ALL=C git'
alias xargs=parallel
alias grep=ack
alias screen=tmux
