# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

alias gup='OPWD=$PWD ; [ ! -d /root/dnssec-data ] && ( cd /root ; git clone https://github.com/dnssec-workshop/dnssec-data ) && cd /root/dnssec-data && git pull --force && rsync -v -rptgoD --copy-links /root/dnssec-data/$HOSTNAME/ / ; cd $OPWD'
