#!/bin/bash

Session name
SESSION_NAME="neovim"

# Check if the tmux session already exists
#!/bin/bash

# Session name
SESSION_NAME="neovide"

# Main path (Documents directory)
MAIN_PATH="$HOME/Documents"

# Check if the tmux session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null
if [ $? == 0 ]; then
  # If the session exists, kill it first
  tmux kill-session -t $SESSION_NAME
fi

# Create a new session and run Neovim in the specified directory
tmux new-session -d -s $SESSION_NAME -c $MAIN_PATH   # Start tmux session in background with working directory
tmux send-keys -t $SESSION_NAME 'neovide' C-m    # Send 'nvim' to the tmux session

# Attach to the tmux session
tmux attach-session -t $SESSION_NAME    # Attach tmux session

