source ~/.profile

  # If a custom short code was requested, set the form value.
  if [ -n "$2" ]; then VALUES="$VALUES -F \"code=$2\""; fi

  # Send the request to GitHub and grab the Location header.
  RESPONSE=$(eval "curl -i https://git.io $VALUES 2>&1" | grep Location)

  # Remove the header name and echo only the generated short link.
  echo "${RESPONSE//Location: /}"
}

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

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