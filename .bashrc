 [ -z "$PS1" ] && return

#Vim mode in bash
set -o vi
#Write history in realtime
shopt -s histappend

#aliases
alias ls='ls -G'
alias gcv='git commit --verbose'
alias gca='git commit -a --verbose'
alias gst='git status'
alias ll='ls -l'
alias la='ls -a'
alias mysql='mysql5'
# Use gits word-diffing 
alias wdiff="git diff --color-words --no-index"
# Git is picky about locale
alias git='LC_ALL=C git'
# Parallel is like xargs, except better
alias xargs=parallel
# Wrapper for ssh, for restoring iterm2 tabcolors
alias ssh=resetting-ssh
# Add ssh-key to agent for 10 hours
alias ssh-add='ssh-add -t 36000'

parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
 }

#change the prompt
setPrompt() {
    #local GREEN_FG="\[\033[32m\]"
    #local DEFAULT_FG="\033[39m\]"
    local GREEN_FG="$(tput setaf 2)"
    local DEFAULT_FG="$(tput sgr0)"
    local BLUE_FG="$(tput bold ; tput setaf 4)"
    local YELLOW_FG="$(tput setaf 3)"

    local BRANCH_COLOR="\[\033[00;35m\]"
    # Directory and Git-branch
    local PROMPT_1="${BLUE_FG}\w${BRANCH_COLOR}\$(parse_git_branch)\n"
    # Username and hostname
    local PROMPT_2="${DEFAULT_FG}[${GREEN_FG}\u${DEFAULT_FG}@${GREEN_FG}localhost${DEFAULT_FG}]\n"
    # Line for new input
    local PROMPT_3="> "
    export PS1="${PROMPT_1}${PROMPT_2}${PROMPT_3}"
}
setPrompt

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
#ignore same inputs in history
export HISTIGNORE="cd:exit:pwd:hostname"
export HISTCONTROL="ignoreboth"
export HISTSIZE=10000
export HISTTIMEFORMAT='%F %T '
export TERM=xterm-color
export SVN_EDITOR=/usr/local/bin/vim
export GIT_EDITOR=/usr/local/bin/vim
export ANT_HOME=/Users/twikstro/Tools/ant
export JAVA_HOME=/Library/Java/Home
export GIT_PS1_SHOWDIRTYSTATE=1

export JAVA_OPTS="-Xmx4048M -Xms2024M -XX:PermSize=512M -XX:MaxPermSize=1024M"
export ANT_OPTS="-Xmx4048M -Xms2024M -XX:PermSize=512M -XX:MaxPermSize=1024M"
# It is nice to be able to see directory names from 'ls' output
export LSCOLORS=Exfxcxdxbxegedabagacad
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

PATH=/usr/local/bin:$PATH
# Apache Ant binaries
PATH=$PATH:$ANT_HOME/bin
# Local tools
PATH=$PATH:$HOME/Tools/bin
# Python checkers etc.
PATH=$PATH:/usr/local/share/python
export PATH

# Git autocompletion
source /usr/local/etc/bash_completion.d/git-completion.bash
# Man autocompletion
source ~/Tools/bin/manbasedcompletion.sh
# Bash completion for brew
source $(brew --repository)/Library/Contributions/brew_bash_completion.sh
