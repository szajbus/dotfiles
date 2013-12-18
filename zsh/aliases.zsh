# system
alias grep="grep --color"
alias l="ls -GFalh"
alias ll="ls -GFalh"
alias ls="ls -GF"

# git
which hub > /dev/null && alias git="hub"
alias g="git"
alias gd="git diff"
alias gf="git fetch"
alias gp="git push"
alias gpf="git push --force"
alias gpl="git pull"
alias gs="git status"

# dev
alias dt="tail -F -n 0 log/development.log"
which pry > /dev/null && alias irb="pry"
alias jsonp="ruby -r json -e 'puts JSON.pretty_generate(JSON.parse(readlines.join))'"
alias rt="touch tmp/restart.txt"

# hussar
alias hsr="~/dev/hussar-docker/bin/hsr"
