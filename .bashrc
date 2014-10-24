 [ -z "$PS1" ] && return

#Vim mode in bash
set -o vi
#Write history in realtime
shopt -s histappend

#aliases
alias gcv='git commit --verbose'
alias gca='git commit -a --verbose'
alias gst='git status'
alias gitroot='cd "$(git rev-parse --show-toplevel)"'
alias gg="git grep -i"

alias ls='ls -G --color=auto'
alias ll='ls -l'
alias la='ls -a'

alias mysql='mysql5'
# Use gits word-diffing
alias wdiff="git diff --color-words --no-index"
# Git is picky about locale
alias git='LC_ALL=C git'
# Parallel is like xargs, except better
alias xargs=parallel
alias coverage=python-coverage

# TODO: ssh agent
# alias ssh-add='ssh-add -t 36000'

alias rebuild_ycm='cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer'
alias gitwho='for ref in $(git for-each-ref --sort=-committerdate --format="%(refname)" refs/remotes ); do git log -n1 $ref --pretty=format:"%Cgreen%cr%Creset %C(yellow)%d%Creset %C(bold blue)<%an&>%Creset%n" | cat ; done | awk '"'! a["'$0'"]++'";

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

#complete -C /usr/share/java/ant-1.8.4/bin/complete-ant-cmd.pl ant
. /etc/bash_completion

# Ignore .pyc files in filename autocompletion
FIGNORE=pyc
#ignore same inputs in history
HISTIGNORE="cd*:exit:pwd:hostname:ls:exit:clear"
HISTCONTROL="ignoreboth"
HISTSIZE=100000
HISTFILESIZE=100000
HISTTIMEFORMAT='%F %T  '
TERM=xterm-256color
export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim
# alias vim=/usr/bin/vim
# My vim croquet experiment
alias vim='/usr/bin/vim -w ~/.vimlog "$@"'
# export => seen in env, no export => seen in set
export ACK_PAGER_COLOR="less -R"
export ANT_HOME=/Users/twikstro/Tools/ant
# Kone specific
export EXTRA_SCONSFLAGS='--m64 --ln --clang'
#export DISTCC_HOSTS="+zeroconf"
export SCONS_CACHE_DIR=/mnt/scache
export SCONSFLAGS="$SCONSFLAGS -j8 --m64"

JAVA_HOME=/Library/Java/Home
GIT_PS1_SHOWDIRTYSTATE=1

export JAVA_OPTS="-Xmx4048M -Xms2024M -XX:PermSize=512M -XX:MaxPermSize=1024M"
export ANT_OPTS="-Xmx4048M -Xms2024M -XX:PermSize=512M -XX:MaxPermSize=1024M"
# It is nice to be able to see directory names from 'ls' output
#export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=36:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:*.deb=90'
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

PATH=/usr/locar/bin:$PATH
# Apache Ant binaries
PATH=$PATH:$ANT_HOME/bin
# Local tools
PATH=$PATH:$HOME/Tools/bin
# TODO?  Adding this due to complaint of missing diff-highlight command
PATH=$PATH:/usr/local/Cellar/git/1.8.4/share/git-core/contrib/diff-highlight/


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PYTHONSTARTUP="$HOME/.pythonrc"

source ~/configs/.bashrc_xterm
source ~/.bashrc_secure
