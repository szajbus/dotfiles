COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_GREEN='\033[0;32m'
COLOR_CYAN='\033[0;36m'
COLOR_PURPLE='\033[0;35m'
COLOR_RESET='\033[0m'

function prompt-setup {
  local pwd="${COLOR_GREEN}\w${COLOR_RESET}"
  local git_info='$(prompt-git-info)'
  local user_indicator='\$'

  if [[ $(uname) == "Darwin" ]]; then
    local prefix=""
  else
    local prefix="${COLOR_PURPLE}\u${COLOR_RESET}@${COLOR_YELLOW}\h${COLOR_RESET}:"
  fi

  export PS1="${prefix}${pwd} ${git_info}${user_indicator} "
}

function prompt-git-info {
  git rev-parse 2> /dev/null

  if [[ $? -eq 0 ]]; then
    local branch="${COLOR_CYAN}$(git symbolic-ref --short HEAD)${COLOR_RESET}"

    # Get current status
    while IFS=$"\n" read line; do
      [[ "$line" =~ ^[MADRC]\ \ .* ]]       && local staged="${COLOR_GREEN}●${COLOR_RESET}"
      [[ "$line" =~ ^.[MADRC]\ .* ]]        && local unstaged="${COLOR_RED}●${COLOR_RESET}"
      [[ "$line" =~ ^(AA|DD|U.|.U)\ .* ]]   && local unstaged="${COLOR_RED}●${COLOR_RESET}"
      [[ "$line" =~ ^\?\?\ .* ]]            && local untracked="${COLOR_YELLOW}●${COLOR_RESET}"
    done < <(git status --porcelain 2> /dev/null)

    echo -e "[${branch}${staged}${unstaged}${untracked}]"
  fi
}

prompt-setup
