setopt prompt_cr
setopt prompt_percent
setopt prompt_sp
setopt prompt_subst

function prompt-setup {
  setopt local_options
  unsetopt xtrace ksh_arrays

  local pwd='%F{green}%~%f'
  local git_info='$(prompt-git-info)'
  local user_indicator='%(!.#.$)'

  if [[ $(uname) == "Darwin" ]]; then
    local prefix=""
  else;
    local prefix='%F{magenta}%n%f@%F{yellow}%m%f'
  fi

  PROMPT="${prefix}${pwd} ${git_info}${user_indicator} "
}

function prompt-git-info {
  git rev-parse 2> /dev/null

  if [[ $? -eq 0 ]]; then
    local branch="%F{cyan}$(git symbolic-ref --short HEAD)%f"

    # Get current status
    while IFS=$'\n' read line; do
      local code=${line:0:2}
      [[ "$code" == [MADRC]\  ]]        && local staged="%F{green}●$%f"
      [[ "$code" == ?[MADRC] ]]         && local unstaged="%F{red}●$%f"
      [[ "$code" == (AA|DD|U?|?U) ]]    && local unstaged="%F{red}●$%f"
      [[ "$code" == \?\? ]]             && local untracked="%F{yellow}●$%f"
    done < <(git status --porcelain 2> /dev/null)

    echo "[${branch}${staged}${unstaged}${untracked}]"
  fi
}

prompt-setup "$@"
