COLOR_RED='\001\033[0;31m\002'
COLOR_YELLOW='\001\033[0;33m\002'
COLOR_GREEN='\001\033[0;32m\002'
COLOR_CYAN='\001\033[0;36m\002'
COLOR_PURPLE='\001\033[0;35m\002'
COLOR_RESET='\001\033[0m\002'

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
      local code=${line:0:2}
      [[ "$code" =~ ^[MADRC]\  ]]        && local staged="${COLOR_GREEN}●${COLOR_RESET}"
      [[ "$code" =~ ^.[MADRC] ]]         && local unstaged="${COLOR_RED}●${COLOR_RESET}"
      [[ "$code" =~ ^(AA|DD|U?|?U) ]]    && local unstaged="${COLOR_RED}●${COLOR_RESET}"
      [[ "$code" =~ ^\?\? ]]             && local untracked="${COLOR_YELLOW}●${COLOR_RESET}"
    done < <(git status --porcelain 2> /dev/null)

    echo -e "[${branch}${staged}${unstaged}${untracked}]"
  fi
}

prompt-setup
