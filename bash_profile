# aliases
alias ll='ls -lhG'      # list long
alias lld='ls -lhdG */' # list long directories
alias la='ls -lhaG'     # list all (includes hidden)
alias lr='ls -ltG'      # list recent (first)
alias vi='nvim'
alias be='bundle exec'
alias ber='bundle exec rspec --format documentation'
alias vpn='sudo \vpn'

# editor for fc / C-xC-e
export EDITOR=nvim

# git
source /usr/local/git/contrib/completion/git-completion.bash
source /usr/local/git/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
PROMPT_COMMAND='__git_ps1 "[\u@\h \W" "]\\\$ "'

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# workaround for MacOs HighSierra fork protection breaking sidekiq
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# disable MacOS Catalina zsh warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# node nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/etordera/.sdkman"
[[ -s "/Users/etordera/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/etordera/.sdkman/bin/sdkman-init.sh"
