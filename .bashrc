echo "Welcome!"
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

# See https://github.com/git/git/blob/v2.10.1/contrib/completion/git-prompt.sh
source ~/scripts/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true GIT_PS1_SHOWUNTRACKEDFILES=true

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (%s)")\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Git completion
source ~/scripts/git-completion.bash

# Homebrew
# export HOMEBREW_GITHUB_API_TOKEN=278535757b3accd87e9577eb435c05b76d3e6f50

# Bash completion
# See https://www.mariusv.com/bash-auto-completion-in-iTerm2-osx/
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

# Kite!
PATH=$HOME/bin:$PATH

# Perl
#PATH="/Users/gonzalobulnes/perl5/bin${PATH+:}${PATH}"; export PATH;
#PERL5LIB="/Users/gonzalobulnes/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/Users/gonzalobulnes/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/Users/gonzalobulnes/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/Users/gonzalobulnes/perl5"; export PERL_MM_OPT;

# Golang
export GOPATH=$HOME/src/go
PATH=$GOPATH/bin:$PATH

# added by Anaconda3 4.1.1 installer
export PATH="/Users/gonzalobulnes/anaconda/bin:$PATH"

# Eternal bash history.
# Source: https://superuser.com/a/664061
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Kumo
export AWS_DEFAULT_REGION=us-east-1

# See http://wiki.ros.org/indigo/Installation/OSX/Homebrew/Source<Paste>
export PATH=/usr/local/bin:$PATH

unset DOCKER_HOST
unset DOCKER_MACHINE_NAME
unset DOCKER_TLS_VERIFY
unset DOCKER_CONFIG
unset DOCKER_CERT_PATH

set -o vi
eval "$(aliases init --global)"
