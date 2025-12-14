#!/bin/bash
# Quick VM management commands

SESSION_NAME="vm-management"

# Check if tmux session exists
if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "❌ Tmux session '$SESSION_NAME' not found!"
    echo "Run './azure-tmux.sh' first to create the session."
    exit 1
fi

show_help() {
    echo "VM Quick Commands"
    echo "Usage: $0 <command>"
    echo ""
    echo "Commands:"
    echo "  update       - Run apt update && apt upgrade on all VMs"
    echo "  reboot       - Reboot all VMs" 
    echo "  status       - Check system status (uptime, disk, memory)"
    echo "  docker       - Install Docker on all VMs"
    echo "  logs         - Check system logs"
    echo "  custom       - Enter custom command interactively"
    echo "  attach       - Attach to the tmux session"
    echo "  list         - List all VMs in SSH config"
    echo ""
    echo "Examples:"
    echo "  $0 update"
    echo "  $0 status" 
    echo "  $0 custom"
}

run_on_all() {
    local command="$1"
    echo "🚀 Running on all VMs: $command"
    echo "   (Commands will execute in the All-VMs window)"
    
    # Send command to the All-VMs window (synchronized panes)
    tmux send-keys -t "$SESSION_NAME:All-VMs" "$command" Enter
}

case "$1" in
    "update")
        run_on_all "sudo apt update && sudo apt upgrade -y"
        ;;
    "reboot")
        echo "⚠️  This will reboot ALL VMs. Continue? (y/N)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            run_on_all "sudo reboot"
        else
            echo "Cancelled."
        fi
        ;;
    "status")
        run_on_all "echo '=== VM: \$(hostname) ==='; uptime; df -h /; free -h; echo"
        ;;
    "docker")
        run_on_all "curl -fsSL https://get.docker.com | sh && sudo usermod -aG docker \$USER"
        ;;
    "logs")
        run_on_all "sudo journalctl --since '1 hour ago' --no-pager | tail -10"
        ;;
    "custom")
        echo "Enter command to run on all VMs:"
        read -r custom_command
        if [ -n "$custom_command" ]; then
            run_on_all "$custom_command"
        fi
        ;;
    "attach")
        tmux attach -t $SESSION_NAME
        ;;
    "list")
        echo "VMs from ~/.ssh/config:"
        /bin/cat ~/.ssh/config | grep -E "^Host " | awk '{print "  - " $2}' | grep -v "*" | grep -v "#"
        ;;
    *)
        show_help
        ;;
esac