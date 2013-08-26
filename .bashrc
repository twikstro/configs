 [ -z "$PS1" ] && return

# Git autocompletion
source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh
# Man autocompletion
source ~/Tools/bin/manbasedcompletion.sh
# Bash completion for brew
source $(brew --repository)/Library/Contributions/brew_bash_completion.sh

#Vim mode in bash
set -o vi
#Write history in realtime
shopt -s histappend

#aliases
alias gcv='git commit --verbose'
alias gca='git commit -a --verbose'
alias gst='git status'
alias gr='cd "$(git rev-parse --show-toplevel)"'

alias ls='ls -G'
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
alias strace='echo use dtruss on Mac OS'

alias rebuild_ycm='cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \[\1\] $(parse_git_dirty)/"
 }

parse_git_dirty() {
     [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
 }

#change the prompt
setPrompt() {
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

updateRepos() {
    for repo in devel databases configuration jenkins-repo; do cd $repo && git pull && cd -; done
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

complete -C /usr/share/java/ant-1.8.4/bin/complete-ant-cmd.pl ant

#ignore same inputs in history
HISTIGNORE="cd:exit:pwd:hostname:ls:pwd:history:exit:clear"
HISTCONTROL="ignoreboth"
HISTSIZE=10000
HISTTIMEFORMAT='%F %T  '
TERM=xterm-256color
SVN_EDITOR=/usr/local/bin/vim
GIT_EDITOR=/usr/local/bin/vim
# export => seen in env, no export => seen in set
export ANT_HOME=/Users/twikstro/Tools/ant
JAVA_HOME=/Library/Java/Home
GIT_PS1_SHOWDIRTYSTATE=1

export JAVA_OPTS="-Xmx4048M -Xms2024M -XX:PermSize=512M -XX:MaxPermSize=1024M"
export ANT_OPTS="-Xmx4048M -Xms2024M -XX:PermSize=512M -XX:MaxPermSize=1024M"
# It is nice to be able to see directory names from 'ls' output
export LSCOLORS=Exfxcxdxbxegedabagacad
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

PATH=/usr/locar/bin:$PATH
# Apache Ant binaries
PATH=$PATH:$ANT_HOME/bin
# Local tools
PATH=$PATH:$HOME/Tools/bin
# TODO?  Adding this due to complaint of missing diff-highlight command
PATH=$PATH:/usr/local/Cellar/git/1.8.4/share/git-core/contrib/diff-highlight/


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
