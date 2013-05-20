autoload -Uz git-current-branch git-is-repo ruby-version

setopt prompt_cr
setopt prompt_percent
setopt prompt_sp
setopt prompt_subst

function prompt-setup {
  setopt local_options
  unsetopt xtrace ksh_arrays

  local user='%F{magenta}%n%f@%F{yellow}%m%f'
  local pwd='%F{green}%~%f'
  local git_info='$(prompt-git-info)'
  local ruby_info='$(prompt-ruby-info)'
  local user_indicator='%(!.#.$)'

  PROMPT="${user} ${pwd} ${git_info}${user_indicator} "
  RPROMPT="${ruby_info}"
}

function prompt-git-info {
  if git-is-repo; then
    local branch="$(git-current-branch)"

    while IFS=$'\n' read line; do
      [[ "$line" == ([ACDMT][\ MT]|[ACMT]D)\ * ]] && local added='%F{green}●%f' || local dirty='%F{red}●%f'
    done < <(git status --porcelain 2> /dev/null)

    echo "[%F{cyan}${branch}%f${added}${dirty}]"
  fi
}

function prompt-ruby-info {
  echo "[%F{blue}$(ruby-version)%f]"
}

prompt-setup "$@"
