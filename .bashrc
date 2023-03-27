# ~/.bashrc
export EDITOR=vim
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
shopt -s checkwinsize

# Colors for ls
eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Source aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Node.js
export PATH="$HOME/.npm-global/bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Python
export PATH="$HOME/.local/bin:$PATH"
