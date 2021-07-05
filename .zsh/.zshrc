# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ZSH Settings. {{{
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/opt/fzf/bin:/Applications/MySQLWorkbench.app/Contents/MacOS:/Library/TeX/texbin:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"

# Quicker compinit.
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
    compinit
else
    compinit -C
fi

# Autocomplete options.
unsetopt menu_complete
unsetopt flowcontrol

setopt always_to_end
setopt auto_menu
setopt complete_in_word

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=1

# For AWS ECR credential provider
export AWS_SDK_LOAD_CONFIG=true

# Use vim where possible.
export EDITOR='vim'

# Needed to sign Git commits with GPG.
export GPG_TTY=$(tty)

# Shorter key timeout
export KEYTIMEOUT=1

# Specify directories outside of $GOROOT that contains source for Go projects.
# Can be a list.
export GOPATH=$HOME/go

# Set Cosmos Settings
export COSMOS_CERT=/etc/pki/tls/certs/client.crt
export COSMOS_CERT_KEY=/etc/pki/tls/private/client.key

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# Allow changing directories without `cd`.
setopt autocd
# Dont overwrite history.
setopt append_history
# Also record time and duration of commands.
setopt extended_history
# Share history between multiple shells.
setopt share_history
# Clear duplicates when trimming internal hist.
setopt hist_expire_dups_first
# Dont display duplicates during searches.
setopt hist_find_no_dups
# Ignore consecutive duplicates.
setopt hist_ignore_dups
# Remember only one unique copy of the command.
setopt hist_ignore_all_dups
# Remove superfluous blanks.
setopt hist_reduce_blanks
# Omit older commands in favor of newer ones.
setopt hist_save_no_dups
# Ignore commands that start with space.
setopt hist_ignore_space

# Load colours into shell variables https://github.com/ninrod/dotfiles/issues/134
autoload -U colors
colors
# }}}
# Antibody. {{{
source <(antibody init)
antibody bundle << EOF
robbyrussell/oh-my-zsh path:plugins/fancy-ctrl-z
robbyrussell/oh-my-zsh path:plugins/git
robbyrussell/oh-my-zsh path:plugins/tmux
robbyrussell/oh-my-zsh path:plugins/vi-mode

b4b4r07/enhancd
djui/alias-tips
docker/cli path:contrib/completion/zsh
seebi/dircolors-solarized
zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
zsh-users/zsh-history-substring-search
zsh-users/zsh-syntax-highlighting
EOF

# Antibody glob means we have to do this manually: https://github.com/getantibody/antibody/blob/master/bundle/zsh.go#L35
fpath=($fpath $(antibody list | grep docker/cli | awk '{print $2"/contrib/completion/zsh"}'))

source ~/src/dotfiles/utilities.zsh
# }}}
# Mappings. {{{
# Fix shift-tab in vi-mode.
bindkey '^[[Z' reverse-menu-complete

# Disable execute-named-command when pressing colon in vi-mode.
bindkey -M vicmd -r ':'
bindkey -M vicmd ':' vi-add-next
# }}}
# Plugins. {{{
# Autosuggest.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'

# Enable JIRA autocompletion.
source <(jira --completion-script-zsh)

# Enhancd.
export ENHANCD_FILTER=fzf

# Asdf.
source /usr/local/opt/asdf/asdf.sh
source /usr/local/etc/bash_completion.d/asdf.bash

# Direnv.
eval "$(direnv hook zsh)"

# Enable kubectl completion.
source <(kubectl completion zsh)
alias k=kubectl

# Enable argocd autocompletion
source <(argocd completion zsh)

# Enable gcloud autocompletion.
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# FZF.
source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function _gen_fzf_default_opts() {

    local paper_blue="#005faf"
    local paper_blue_bgp="#0087af"
    local paper_blue_fgp="#eeeeee"
    local paper_pink="#d70087"
    local paper_green="#5f8700"

    local onedark_blue="#61afef"
    local onedark_green="#98c379"
    local onedark_yellow="#e5c07b"

    local challenger_deep_red="#ff8080"
    local challenger_deep_dark_red="#ff5458"
    local challenger_deep_green="#95ffa4"
    local challenger_deep_dark_green="#62d196"
    local challenger_deep_yellow="#ffe9aa"
    local challenger_deep_dark_yellow="#ffb378"
    local challenger_deep_blue="#91ddff"
    local challenger_deep_dark_blue="#65b2ff"
    local challenger_deep_purple="#c991e1"
    local challenger_deep_dark_purple="#906cff"
    local challenger_deep_cyan="#aaffe4"
    local challenger_deep_dark_cyan="#63f2f1"
    local challenger_deep_clouds="#cbe3e7"
    local challenger_deep_dark_clouds="#a6b3cc"

    local ui_tint=$challenger_deep_yellow

    export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,bg+:$challenger_deep_dark_purple,hl:$challenger_deep_dark_cyan
    --color header:$ui_tint,info:$ui_tint,spinner:$ui_tint,prompt:$ui_tint
    --color marker:#ffffff,pointer:#ffffff,hl+:$challenger_deep_dark_cyan,fg+:#ffffff"
}
_gen_fzf_default_opts

function fzf_git_checkout() {
    local branches branch

    branches=$(git branch -vv) &&
        branch=$(echo "$branches" | fzf +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
    }

# Hub.
eval $(hub alias -s)

# Spaceship
eval "$(starship init zsh)"
# }}}
# {{{ My stuff
source ~/src/secrets/sh/functions/functions.sh

export HTTPIE_CONFIG_DIR=~/src/dotfiles/httpie-profiles/default

# }}}

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/ziyad/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
# to see later  ZSH_THEME="maza"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias e="exa --group-directories-first"
alias el="exa -l --icons --group-directories-first"
alias t="tmux"
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Users/ziyad/.scc/scc.py"
alias p3="python3"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Users/ziyad/.scc/scc.py:/Users/ziyad/.scc/scc.py"
alias scc='/Users/ziyad/.scc/scc.py'
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
export PATH="/usr/local/lib/python3.7/site-packages:$PATH"
export PATH="$HOME/workspace/flutter/bin:$PATH"

PYTHONPATH=$PYTHONPATH:/usr/local/Cellar/python@3.8/3.8.2/bin/python3.8
