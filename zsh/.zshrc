# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="solus"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
alias ll='ls -shal'

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

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export PATH="/usr/local/opt/maven@3.5/bin:$PATH"

# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

PATH=$PATH:$HOME/bin

rml() {
    sed -i '' '/^'"$1"'$/d' "$2"
}

go() {
    ssh bryce.eklund@"$1"
}

alias ll='ls -shal'

# color variables
GREEN='\033[0;32m'
NC='\033[0m'

# DNS shortcuts
function mx { printf "${GREEN}$(dig mx +short "$1")\n${NC}"; }
function spf { printf "${GREEN}$(dig txt +short "$1")\n${NC}"; }
function cname { printf "${GREEN}$(dig cname +short "$1")\n${NC}"; }

alias flush='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias nettest='ping 8.8.8.8'
alias greg='grep'
alias brep='grep'
ssl() {
    cd /Volumes/GoogleDrive/My\ Drive/legacy_ssl
    echo '====Making "$@" Directory===='
    mkdir "$@"
    cd "$@"
    echo '====Generating Key===='
    openssl genrsa -des3 -out "$@".key 2048
    echo '====Key Created===='
    echo '====Generating CSR===='
    openssl req -new -key "$@".key -out "$@".csr
    echo '====CSR Created===='
    echo '====Removing Password===='
    mv "$@".key "$@".key.pass
    openssl rsa -in "$@".key.pass -out "$@".key
    open .
}

sslkey() {
    openssl genrsa -des3 -out "$1".key 2048 -sha256
}

sslsan() {
    openssl req -new -key "$1".key -out "$1".csr -config "$1".cfg
}

validatessl() {
    dos2unix *
    openssl x509 -noout -modulus -in *.crt | openssl md5
    openssl rsa -noout -modulus -in *.key | openssl md5
}

validatecsr() {
    openssl req -noout -modulus -in *.csr | openssl md5
}
