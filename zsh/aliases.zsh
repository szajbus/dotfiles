# system
alias grep="grep --color"
alias l="ls -GFalh"
alias ll="ls -GFalh"
alias ls="ls -GF"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL ."

# git
which hub > /dev/null && alias git="hub"
alias g="git"
alias gd="git diff"
alias gf="git fetch"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpff="git push --force"
alias gpl="git pull"
alias gs="git status"

# dev
alias dt="tail -F -n 0 log/development.log"
which pry > /dev/null && alias irb="pry"
alias jsonp="ruby -r json -e 'puts JSON.pretty_generate(JSON.parse(readlines.join))'"
alias rt="touch tmp/restart.txt"
alias rake="bundle exec rake"

# docker-machine
alias dm="eval \"$(docker-machine env default 2> /dev/null)\""
