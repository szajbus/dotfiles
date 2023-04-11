### tmux
if [ -t 1 ] && [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
  tmux attach-session -d -t $USER || tmux new-session -s $USER
fi
