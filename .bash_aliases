# ~/.bash_aliases: executed by bash(1) for non-login shells.
# for examples

######
# LS #
######

alias ll='ls -lhcF'
alias la='ls -AF'
alias lla='ls -AFchl'

########
# grep #
########
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# color grep alias for piping to less
alias cgrep='grep --color=always'
alias less='less -R'

#############
# Shortcuts #
#############

#cd Shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

#################
# Vim/Vi/Neovim #
#################

alias vi="nvim -u ~/.vimrc.sparse"

###############
# Replacement #
# Commands w/ #
# Different   #
# Flags       #
###############

#Disk usage for humans
alias df='df -h'

#Directory usage for humans
alias du="du -h"

#######
# Git #
#######

alias gs="git status"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias ga="git add"
alias grt='cd $(git rev-parse --show-toplevel || echo '.")"

#########
# Other #
#########

#Start text-based star wars
alias starwars="telnet towel.blinkenlights.nl"

# Update and prune homebrew packages
alias bubu='brew update && brew upgrade && brew cleanup'

# Use homebrew emacs if available
if [ -f /usr/local/bin/emacs ]; then
  alias emacs="/usr/local/bin/emacs"
fi
