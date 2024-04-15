# ALIAS
alias bare='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias lazygit_bare='lazygit --git-dir=$HOME/dotfiles --work-tree=$HOME'
# alias update_grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

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
#GRADLE
export  PATH=$HOME/my_apps/gradle/bin:$PATH


# YAZI
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ];
 then
exec tmux
fi


#git init --bare $HOME/dotfiles
# alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc)
# bash
# config config --local status.showUntrackedFiles no


