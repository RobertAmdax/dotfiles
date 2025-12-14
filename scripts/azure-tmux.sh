#!/bin/bash
# Multi-VM tmux session script - reads VM hosts from ~/.ssh/config

SESSION_NAME="vm-management"

# Function to extract VM hosts from SSH config
get_vm_hosts() {
    if [ ! -f ~/.ssh/config ]; then
        echo "❌ No ~/.ssh/config file found!"
        exit 1
    fi

    # Extract all Host entries (excluding wildcards and comments)
    /bin/cat ~/.ssh/config | grep -E "^Host " | awk '{print $2}' | grep -v "*" | grep -v "#"
}

# Get list of VM hosts from SSH config
VM_HOSTS=($(get_vm_hosts))

if [ ${#VM_HOSTS[@]} -eq 0 ]; then
    echo "❌ No VM hosts found in ~/.ssh/config"
    exit 1
fi

echo "Found VM hosts: ${VM_HOSTS[*]}"

# Filter out test machines - only keep production servers
FILTERED_VMS=()
for vm in "${VM_HOSTS[@]}"; do
    if [[ "$vm" != conctest* ]]; then
        FILTERED_VMS+=("$vm")
    fi
done
VM_HOSTS=("${FILTERED_VMS[@]}")

echo "Using production VMs: ${VM_HOSTS[*]}"
VMS=("${VM_HOSTS[@]}")

# Kill existing session if it exists
tmux kill-session -t $SESSION_NAME 2>/dev/null

# Create new session
tmux new-session -d -s $SESSION_NAME

# Create a window for each VM
for i in "${!VMS[@]}"; do
    vm="${VMS[$i]}"
    if [ $i -eq 0 ]; then
        # First VM uses the initial window
        tmux rename-window -t $SESSION_NAME:0 "${vm}"
        tmux send-keys -t $SESSION_NAME:0 "ssh $vm" Enter
        sleep 1  # Give time for connection
    else
        # Create new window for additional VMs
        tmux new-window -t $SESSION_NAME -n "${vm}"
        tmux send-keys -t $SESSION_NAME:"${vm}" "ssh $vm" Enter
        sleep 1  # Give time for connection
    fi
done

# Wait a bit for connections to establish
sleep 3

# Create a "control" window with synchronized panes
tmux new-window -t $SESSION_NAME -n "All-VMs"

# Split into panes for each VM
for i in "${!VMS[@]}"; do
    vm="${VMS[$i]}"
    if [ $i -eq 0 ]; then
        # First pane
        tmux send-keys -t $SESSION_NAME:All-VMs "ssh $vm" Enter
        sleep 2  # Wait for connection
    else
        # Split and add new pane
        tmux split-window -t $SESSION_NAME:All-VMs
        tmux select-layout -t $SESSION_NAME:All-VMs tiled
        tmux send-keys -t $SESSION_NAME:All-VMs "ssh $vm" Enter
        sleep 2  # Wait for connection
    fi
done

# Wait for all connections to establish
sleep 5

# Enable pane synchronization for the All-VMs window
tmux set-window-option -t $SESSION_NAME:All-VMs synchronize-panes on

echo "Tmux session '$SESSION_NAME' created!"
echo "Found VMs: ${VMS[*]}"
echo "Windows:"
echo "  - Individual VM windows (${VMS[*]})"
echo "  - All-VMs window with synchronized panes"
echo ""
echo "To attach: tmux attach -t $SESSION_NAME"
echo "In All-VMs window, commands will run on ALL VMs simultaneously!"
echo ""
echo "Key shortcuts:"
echo "  Ctrl+a + : set synchronize-panes off  # Disable sync"
echo "  Ctrl+a + : set synchronize-panes on   # Enable sync"