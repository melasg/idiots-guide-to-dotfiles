source ~/.profile

  # If a custom short code was requested, set the form value.
  if [ -n "$2" ]; then VALUES="$VALUES -F \"code=$2\""; fi

  # Send the request to GitHub and grab the Location header.
  RESPONSE=$(eval "curl -i https://git.io $VALUES 2>&1" | grep Location)

  # Remove the header name and echo only the generated short link.
  echo "${RESPONSE//Location: /}"

# bash-completion
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	# Ensure existing Homebrew v1 completions continue to work
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;
# exercism bash-completion
# if [ -f ~/.config/exercism/exercism_completion.bash ]; then
#  . ~/.config/exercism/exercism_completion.bash
# fi

# bash vars
export HISTTIMEFORMAT='%d/%m/%y %T -> '

# cli prefix format
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='[\u@mbp \w$(__git_ps1)]\$ '

# nvm
export NVM_DIR=~/.nvm # don't forget mkdir ~/.nvm
source $(brew --prefix nvm)/nvm.sh
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# node
export NODE_ENV=development

# haskell stack packages
# export PATH=$PATH:~/.local/bin

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# custom scripts
export PATH=$PATH:~/bin

# flutter
export PATH=$PATH:~/projects/dev/flutter/bin

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# virtualenvwrapper
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/Cellar/python3/3.7.2_2/Frameworks/Python.framework/Versions/3.7/bin/python3
# export WORKON_HOME=~/workspace/python/envs/
# source /usr/local/bin/virtualenvwrapper.sh

# # pyenv
# eval "$(pyenv init -)"
# # # auto-activation of virtualenvs
# eval "$(pyenv virtualenv-init -)"
# source $(pyenv root)/completions/pyenv.bash

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;