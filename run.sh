#!/bin/sh

# Set the session name
SESSION_NAME="temperowka"

# Check if the tmux session already exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    # If it exists, attach to the session
    tmux attach-session -t $SESSION_NAME
else
    # Start a new tmux session named "mysession"
    tmux new-session -d -s $SESSION_NAME

    # Split the window vertically
    tmux split-window -h

    # Run command in the first pane
    tmux send-keys -t $SESSION_NAME:0.0 'live-server .' C-m

    # Run command in the second pane
    tmux send-keys -t $SESSION_NAME:0.1 'tailwindcss -i tail.css -o styles.css --watch' C-m

    # Wait for all panes to finish
    tmux wait-for -S session_done

    # Attach to the tmux session
    tmux attach-session -t $SESSION_NAME

    # Destroy the session after the tasks are completed
    tmux kill-session -t $SESSION_NAME
fi

