alias bare='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
source ~/my_apps/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/my_apps/zsh-autosuggestions/zsh-autosuggestions.zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
#
# starship
eval "$(starship init zsh)"

#JAVA
export JAVA_HOME=~/my_apps/java/
export PATH=$JAVA_HOME/bin:$PATH
