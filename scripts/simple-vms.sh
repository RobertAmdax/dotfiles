#!/bin/bash
# Simple VM tmux session - just the essentials

SESSION_NAME="vms"
# Only production VMs (no conctest)
VMS=("conc21" "conc22" "conc26" "elastic" "openvpn" "avax")

# Kill existing session
tmux kill-session -t $SESSION_NAME 2>/dev/null

# Create new session with first VM
tmux new-session -d -s $SESSION_NAME -n "${VMS[0]}"

# Add windows for other VMs
for vm in "${VMS[@]:1}"; do
    tmux new-window -t $SESSION_NAME -n "$vm"
done

# Create the "ALL" window with all VMs in synchronized panes
tmux new-window -t $SESSION_NAME -n "ALL"

# Split into panes for each VM
for i in "${!VMS[@]}"; do
    vm="${VMS[$i]}"
    if [ $i -eq 0 ]; then
        # First pane - just send the ssh command
        tmux send-keys -t $SESSION_NAME:ALL "ssh $vm" Enter
    else
        # Add more panes
        tmux split-window -t $SESSION_NAME:ALL
        tmux select-layout -t $SESSION_NAME:ALL tiled
        tmux send-keys -t $SESSION_NAME:ALL "ssh $vm" Enter
    fi
    sleep 1
done

# Enable synchronization
tmux set-window-option -t $SESSION_NAME:ALL synchronize-panes on

# Go to the ALL window
tmux select-window -t $SESSION_NAME:ALL

echo "✅ Session 'vms' created with synchronized panes!"
echo "📋 Simple commands:"
echo "   tmux attach -t vms     # Connect to session"
echo "   Ctrl+b then d          # Detach from session"  
echo "   Ctrl+b then 1,2,3...   # Switch to individual VM windows"
echo "   Ctrl+b then 'ALL'      # Go to synchronized window"
echo ""
echo "🚀 You're now ready! The 'ALL' window runs commands on all VMs at once."