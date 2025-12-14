# Tmux Guide for VM Management

## What is Tmux?
Tmux (Terminal Multiplexer) lets you:
- Run multiple terminal sessions in one window
- Split screens into panes
- Keep sessions running when you disconnect
- Manage remote servers efficiently

## Basic Concepts

### Sessions, Windows, and Panes
```
Session: vm-management
├── Window 0: conc21     (Individual VM)
├── Window 1: conc22     (Individual VM) 
├── Window 2: conc26     (Individual VM)
└── Window 8: All-VMs    (8 panes, one per VM)
    ├── Pane 0: SSH to conc21
    ├── Pane 1: SSH to conc22
    └── ... (all VMs)
```

## Key Bindings (Your prefix is Ctrl+a)

### Session Management
```bash
# Start/attach to your VM session
tmux attach -t vm-management
# Or use your alias
vmcmd attach

# Detach from session (keeps it running)
Ctrl+a + d

# List all sessions
tmux list-sessions
# Or: Ctrl+a + s
```

### Window Navigation
```bash
# Switch between VM windows
Ctrl+a + 0    # Go to window 0 (conc21)
Ctrl+a + 1    # Go to window 1 (conc22)
Ctrl+a + 8    # Go to All-VMs window

# Next/Previous window
Ctrl+a + n    # Next window
Ctrl+a + p    # Previous window

# List all windows
Ctrl+a + w
```

### Pane Management (In All-VMs window)
```bash
# Navigate between panes
Ctrl+a + arrow keys    # Move between panes
Ctrl+a + h/j/k/l      # Vim-style movement

# Split current pane
Ctrl+a + "            # Split horizontally
Ctrl+a + %            # Split vertically

# Close current pane
Ctrl+a + x            # Close pane (confirm with y)
```

### Synchronized Panes (The Magic!)
```bash
# In All-VMs window - toggle command sync
Ctrl+a + :
set synchronize-panes on     # Commands go to ALL VMs
set synchronize-panes off    # Commands go to one VM only

# Check if sync is enabled
Ctrl+a + :
show-options synchronize-panes
```

## Practical VM Management Workflow

### 1. Start Your VM Session
```bash
vms                    # Creates session with all VMs
tmux attach -t vm-management
```

### 2. Quick Commands (From Another Terminal)
```bash
vmcmd update          # Update all VMs
vmcmd status          # Check status of all VMs  
vmcmd custom          # Run custom command
```

### 3. Interactive Management
```bash
# Attach to session
vmcmd attach

# Go to All-VMs window (usually window 8)
Ctrl+a + 8

# Enable sync (if not already on)
Ctrl+a + :
set synchronize-panes on

# Now type commands - they run on ALL VMs!
sudo apt update
sudo systemctl status docker
df -h
```

### 4. Individual VM Work
```bash
# Switch to specific VM window
Ctrl+a + 0           # Work on conc21 only
Ctrl+a + 1           # Work on conc22 only

# Or in All-VMs window, disable sync
Ctrl+a + :
set synchronize-panes off
# Click on specific pane, work on that VM only
```

## Useful Commands

### System Info on All VMs
```bash
# In synchronized All-VMs window:
hostname && uptime
free -h
df -h /
sudo systemctl status --no-pager
```

### Software Management
```bash
# Update all VMs
sudo apt update && sudo apt upgrade -y

# Install package on all VMs
sudo apt install -y htop

# Check service status
sudo systemctl status nginx
```

### Monitoring
```bash
# Real-time monitoring (Ctrl+C to stop)
htop
top
sudo journalctl -f
```

## Advanced Features

### Copy Mode (Scrolling)
```bash
Ctrl+a + [           # Enter copy mode
Arrow keys           # Scroll up/down
q                    # Exit copy mode
```

### Resize Panes
```bash
Ctrl+a + Ctrl+arrow  # Resize current pane
Ctrl+a + Alt+arrow   # Resize in larger steps
```

### Zoom Pane
```bash
Ctrl+a + z           # Zoom current pane (full screen)
Ctrl+a + z           # Zoom out (back to layout)
```

## Quick Reference Card

| Action | Command |
|--------|---------|
| Attach to VM session | `vmcmd attach` |
| Detach session | `Ctrl+a + d` |
| Go to All-VMs window | `Ctrl+a + 8` |
| Toggle command sync | `Ctrl+a + : set synchronize-panes on/off` |
| Switch windows | `Ctrl+a + 0-9` |
| Navigate panes | `Ctrl+a + arrow keys` |
| Zoom pane | `Ctrl+a + z` |
| Copy mode | `Ctrl+a + [` |

## Pro Tips

### 1. Use Sync for Bulk Operations
- Enable sync in All-VMs window
- Run `sudo apt update` once, affects all VMs
- Great for: updates, installing packages, checking status

### 2. Use Individual Windows for Debugging
- Switch to specific VM window for detailed work
- Debug issues on one server without affecting others

### 3. Keep Sessions Running
- Tmux sessions survive SSH disconnections
- Start long-running tasks and detach
- Come back later to check progress

### 4. Visual Indicators
- Window names show which VM you're on
- Pane borders highlight active pane
- Status bar shows session info

## Example Workflow: Update All VMs

```bash
# Option 1: Quick command
vmcmd update

# Option 2: Interactive
vmcmd attach
Ctrl+a + 8                    # Go to All-VMs
Ctrl+a + : set synchronize-panes on
sudo apt update
sudo apt list --upgradable
sudo apt upgrade -y
sudo reboot                   # If needed

# Option 3: Individual control
Ctrl+a + 0                    # Check conc21 first
sudo apt update
# If good, go to All-VMs and sync
```

This setup gives you powerful control over all your VMs while keeping the flexibility to work on them individually when needed!