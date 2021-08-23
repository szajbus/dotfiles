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
      [[ "$line" == ([ACDMT][\ MT]|[ACMT]D)\ * ]] && local added='%F{green}●%f'
      [[ "$line" == [\ ACMRT]D\ * ]]              && local deleted='%F{red}●%f'
      [[ "$line" == ?[MT]\ * ]]                   && local modified='%F{red}●%f'
      [[ "$line" == R?\ * ]]                      && local added='%F{green}●%f'
      [[ "$line" == (AA|DD|U?|?U)\ * ]]           && local modified='%F{red}●%f'
      [[ "$line" == \?\?\ * ]]                    && local untracked='%F{yellow}●%f'
    done < <(git status --porcelain 2> /dev/null)

    echo "[${branch}${deleted}${added}${modified}${untracked}]"
  fi
}

prompt-setup "$@"
