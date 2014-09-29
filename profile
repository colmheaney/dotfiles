EDITOR='vim';                 export EDITOR
GIT_EDITOR='vim';             export GIT_EDITOR

# Aliases includes
source $HOME/.shell/bash-aliases.bash

export PATH="$HOME/.bin:$PATH"

# recommended by brew doctor
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

eval "$(rbenv init - --no-rehash)"
if [ -f `brew --prefix`/etc/bash_completion ]; then . `brew --prefix`/etc/bash_completion; fi

PS1_PWD_MAX=15
__pwd_ps1() { echo -n $PWD | sed -e "s|${HOME}|~|" -e "s|\(/[^/]*/\).*\(/.\
{${PS1_PWD_MAX}\}\)|\1...\2|"; }

GIT_PS1_SHOWDIRTYSTATE=1
PS1='\[\033[00;34m\]$(__pwd_ps1)$(__git_ps1 "\[\033[01;31m\](%s)")\n$\[\033[00m\] '

