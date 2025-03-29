# system
alias grep="grep --color"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL ."

if is_busybox; then
  alias l="ls -Falh"
  alias ll="ls -Falh"
  alias ls="ls -F"
else
  alias l="ls -GFalh"
  alias ll="ls -GFalh"
  alias ls="ls -GF"
fi

# git
alias g="git"
alias gd="git diff"
alias gdt="git difftool"
alias gf="git fetch"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpff="git push --force"
alias gpl="git pull"
alias gr="git recent"
alias gs="git status"

# dev
which pry > /dev/null && alias irb="pry"
alias jsonp="ruby -r json -e 'puts JSON.pretty_generate(JSON.parse(readlines.join))'"
alias rt="touch tmp/restart.txt"
alias rake="bundle exec rake"
alias cap="bundle exec cap"
alias iex-clean="iex --dot-iex \"\""
alias mtw="mix test.watch"
alias vvv="source .venv/bin/activate"
alias nn-prod="export NOMAD_NAMESPACE=prod"
alias ww="watchexec --exts=ex,exs,heex --stop-timeout=0s --restart --shell=none -- "
alias wwt="ww mix test"

# kubectl
alias k="kubectl"

# kill all BEAM processes except RabbitMQ and ElixirLS
alias kill-beams="ps aux | grep '[b]eam' | grep -v 'rabbitmq\|ElixirLS' | awk '{print \$2}' | xargs -t kill"
alias kill-beams-9="ps aux | grep '[b]eam' | grep -v 'rabbitmq\|ElixirLS' | awk '{print \$2}' | xargs -t kill -9"
