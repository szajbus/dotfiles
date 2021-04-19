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
alias cap="bundle exec cap"
alias iex-clean="iex --dot-iex \"\""
alias mtw="mix test.watch"

# docker-machine
alias dm="eval \"$(docker-machine env default 2> /dev/null)\""

# kubectl
alias k="kubectl"

# kill all BEAM processes except RabbitMQ and ElixirLS
alias kill-beams="ps aux | grep '[b]eam' | grep -v 'rabbitmq\|ElixirLS' | awk '{print \$2}' | xargs -t kill"
alias kill-beams-9="ps aux | grep '[b]eam' | grep -v 'rabbitmq\|ElixirLS' | awk '{print \$2}' | xargs -t kill -9"
