#!/bin/bash

# Claude Code Studio - Global Permissions Setup Script
# Allows common commands globally so Claude Code stops asking for permission
# Interactive selection with numbered list interface

# Don't exit on error immediately - we'll handle errors manually
set +e

# Check if terminal supports colors
if [ -t 1 ] && command -v tput >/dev/null 2>&1 && tput colors >/dev/null 2>&1 && [ "$(tput colors)" -ge 8 ]; then
    # Colors for output
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    MAGENTA='\033[0;35m'
    CYAN='\033[0;36m'
    NC='\033[0m' # No Color
else
    # No colors
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    MAGENTA=''
    CYAN=''
    NC=''
fi

# Function to print colored output
print_status() {
    printf "${BLUE}[INFO]${NC} %s\n" "$1"
}

print_success() {
    printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"
}

print_warning() {
    printf "${YELLOW}[WARNING]${NC} %s\n" "$1"
}

print_error() {
    printf "${RED}[ERROR]${NC} %s\n" "$1"
}

print_header() {
    printf "${CYAN}[HEADER]${NC} %s\n" "$1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Array of common commands with descriptions and danger levels
# Format: "command:description:danger_level"
# Danger levels: safe, caution, danger
declare -a COMMANDS=(
    "cd:Change directory - navigate between folders:safe"
    "ls:List directory contents:safe"
    "pwd:Print working directory - show current location:safe"
    "mkdir:Create directories:safe"
    "rmdir:Remove empty directories:caution"
    "rm:Remove files and directories:danger"
    "cp:Copy files and directories:safe"
    "mv:Move/rename files and directories:caution"
    "chmod:Change file permissions:caution"
    "chown:Change file ownership:caution"
    "find:Search for files and directories:safe"
    "grep:Search text patterns in files:safe"
    "cat:Display file contents:safe"
    "head:Display first lines of files:safe"
    "tail:Display last lines of files:safe"
    "less:View file contents page by page:safe"
    "more:View file contents page by page:safe"
    "touch:Create empty files or update timestamps:safe"
    "echo:Display text:safe"
    "which:Locate command executable:safe"
    "whoami:Display current username:safe"
    "date:Display or set system date:caution"
    "ps:Display running processes:safe"
    "kill:Terminate processes:danger"
    "killall:Terminate processes by name:danger"
    "top:Display running processes (live):safe"
    "htop:Enhanced process viewer:safe"
    "du:Display disk usage:safe"
    "df:Display filesystem disk space usage:safe"
    "free:Display memory usage:safe"
    "uptime:Display system uptime:safe"
    "uname:Display system information:safe"
    "id:Display user and group IDs:safe"
    "groups:Display user groups:safe"
    "history:Display command history:safe"
    "clear:Clear terminal screen:safe"
    "exit:Exit shell:safe"
    "logout:Logout from shell:safe"
    "ssh:Secure shell remote connection:caution"
    "scp:Secure copy files over network:caution"
    "rsync:Synchronize files/directories:caution"
    "curl:Transfer data from/to servers:caution"
    "wget:Download files from web:caution"
    "tar:Archive and compress files:safe"
    "zip:Create zip archives:safe"
    "unzip:Extract zip archives:safe"
    "gzip:Compress files:safe"
    "gunzip:Decompress gzip files:safe"
    "sort:Sort lines in text files:safe"
    "uniq:Remove duplicate lines:safe"
    "wc:Count lines, words, characters:safe"
    "diff:Compare files line by line:safe"
    "patch:Apply differences to files:caution"
    "vim:Text editor:safe"
    "nano:Simple text editor:safe"
    "emacs:Text editor:safe"
    "git:Version control system:safe"
    "npm:Node.js package manager:caution"
    "yarn:Alternative Node.js package manager:caution"
    "pip:Python package manager:caution"
    "brew:macOS package manager:caution"
    "apt:Debian/Ubuntu package manager:danger"
    "yum:Red Hat package manager:danger"
    "dnf:Fedora package manager:danger"
    "pacman:Arch Linux package manager:danger"
    "docker:Container platform:caution"
    "kubectl:Kubernetes command-line tool:caution"
    "terraform:Infrastructure as code:caution"
    "ansible:Configuration management:caution"
    "systemctl:Control systemd services:danger"
    "service:Control system services:danger"
    "crontab:Schedule tasks:caution"
    "at:Schedule one-time tasks:caution"
    "nohup:Run commands immune to hangups:safe"
    "screen:Terminal multiplexer:safe"
    "tmux:Terminal multiplexer:safe"
    "jobs:Display active jobs:safe"
    "bg:Put jobs in background:safe"
    "fg:Bring jobs to foreground:safe"
    "mount:Mount filesystems:danger"
    "umount:Unmount filesystems:danger"
    "fdisk:Manage disk partitions:danger"
    "lsblk:List block devices:safe"
    "lsusb:List USB devices:safe"
    "lspci:List PCI devices:safe"
    "ifconfig:Configure network interface:danger"
    "ip:Show/manipulate routing, network devices:danger"
    "netstat:Display network connections:safe"
    "ss:Display socket statistics:safe"
    "ping:Send ICMP echo requests:safe"
    "traceroute:Trace network route:safe"
    "nslookup:Query DNS servers:safe"
    "dig:DNS lookup utility:safe"
    "awk:Text processing tool:safe"
    "sed:Stream editor for filtering and transforming text:caution"
    "tr:Translate or delete characters:safe"
    "cut:Extract columns from text:safe"
    "paste:Merge lines of files:safe"
    "xargs:Build and execute command lines:caution"
    "tee:Write output to multiple destinations:safe"
    "ln:Create links between files:caution"
    "stat:Display file or filesystem status:safe"
    "file:Determine file type:safe"
    "basename:Extract filename from path:safe"
    "dirname:Extract directory from path:safe"
    "readlink:Display symbolic link target:safe"
    "env:Display or set environment variables:safe"
    "export:Set environment variables:caution"
    "alias:Create command aliases:safe"
    "unalias:Remove command aliases:safe"
    "type:Display command type:safe"
    "help:Display help for built-in commands:safe"
    "man:Display manual pages:safe"
    "info:Display info documents:safe"
    "apropos:Search manual page names:safe"
    "locate:Find files by name:safe"
    "updatedb:Update locate database:caution"
    "cpio:Copy files to/from archives:caution"
    "dd:Convert and copy files:danger"
    "sync:Flush filesystem buffers:caution"
    "fsck:Check and repair filesystems:danger"
    "mkfs:Create filesystems:danger"
)

# Header
echo "=================================================="
echo "   Claude Code Studio - Permissions Setup Tool   "
echo "       Allow Common Commands Globally            "
echo "=================================================="
echo ""

# Check prerequisites
print_status "Checking prerequisites..."

if ! command_exists claude; then
    print_error "Claude Code CLI is not installed. Please install Claude Code first."
    echo "Visit: https://docs.anthropic.com/en/docs/claude-code"
    exit 1
fi

print_success "Prerequisites check passed"
echo ""

# Display available commands
print_header "Available Commands to Allow Globally:"
echo ""

for i in "${!COMMANDS[@]}"; do
    IFS=':' read -r cmd desc danger_level <<< "${COMMANDS[$i]}"
    
    # Set colors and warning indicators based on danger level
    case "$danger_level" in
        "danger")
            cmd_color="$RED"
            warning_indicator="${RED}⚠️  DANGER${NC}"
            ;;
        "caution")
            cmd_color="$YELLOW"
            warning_indicator="${YELLOW}⚠️  CAUTION${NC}"
            ;;
        *)
            cmd_color="$GREEN"
            warning_indicator=""
            ;;
    esac
    
    # Display command with appropriate colors and warnings
    if [ -n "$warning_indicator" ]; then
        printf "${CYAN}%3d.${NC} ${cmd_color}%-12s${NC} - %s ${warning_indicator}\n" $((i + 1)) "$cmd" "$desc"
    else
        printf "${CYAN}%3d.${NC} ${cmd_color}%-12s${NC} - %s\n" $((i + 1)) "$cmd" "$desc"
    fi
done

echo ""
echo "=================================================="
print_status "Color Legend:"
echo ""
printf "  ${GREEN}Green${NC}     - Safe commands (low risk)\n"
printf "  ${YELLOW}Yellow${NC}    - Caution commands (moderate risk) ${YELLOW}⚠️  CAUTION${NC}\n"
printf "  ${RED}Red${NC}       - Dangerous commands (high risk) ${RED}⚠️  DANGER${NC}\n"
echo ""
print_status "Selection Options:"
echo ""
echo "• Enter numbers separated by commas or spaces: 1,3,5 or 1 3 5"
echo "• Enter ranges with dash: 1-10 or 1-5,8-12"
echo "• Enter 'all' to select all commands"
echo "• Enter 'common' to select most commonly used commands (1-40)"
echo "• Enter 'dev' to select development-related commands"
echo "• Enter 'system' to select system administration commands"
echo "• Enter 'safe' to select only safe commands (green)"
echo ""

# Get user selection
while true; do
    read -p "Enter your selection: " -r selection
    
    if [ -z "$selection" ]; then
        print_warning "Please enter a selection."
        continue
    fi
    
    # Initialize array to store selected indices
    selected_indices=()
    
    # Handle special keywords
    case "$selection" in
        "all")
            for i in "${!COMMANDS[@]}"; do
                selected_indices+=($i)
            done
            ;;
        "common")
            for i in {0..39}; do
                if [ $i -lt ${#COMMANDS[@]} ]; then
                    selected_indices+=($i)
                fi
            done
            ;;
        "dev")
            # Development commands: git, npm, yarn, pip, docker, etc.
            dev_commands=("git" "npm" "yarn" "pip" "docker" "kubectl" "terraform" "ansible")
            for i in "${!COMMANDS[@]}"; do
                IFS=':' read -r cmd desc danger_level <<< "${COMMANDS[$i]}"
                for dev_cmd in "${dev_commands[@]}"; do
                    if [ "$cmd" = "$dev_cmd" ]; then
                        selected_indices+=($i)
                        break
                    fi
                done
            done
            ;;
        "system")
            # System administration commands
            sys_commands=("systemctl" "service" "mount" "umount" "fdisk" "ifconfig" "ip" "netstat")
            for i in "${!COMMANDS[@]}"; do
                IFS=':' read -r cmd desc danger_level <<< "${COMMANDS[$i]}"
                for sys_cmd in "${sys_commands[@]}"; do
                    if [ "$cmd" = "$sys_cmd" ]; then
                        selected_indices+=($i)
                        break
                    fi
                done
            done
            ;;
        "safe")
            # Only safe commands (green)
            for i in "${!COMMANDS[@]}"; do
                IFS=':' read -r cmd desc danger_level <<< "${COMMANDS[$i]}"
                if [ "$danger_level" = "safe" ]; then
                    selected_indices+=($i)
                fi
            done
            ;;
        *)
            # Parse manual selection
            # Replace commas with spaces and handle ranges
            selection=$(echo "$selection" | tr ',' ' ')
            
            for item in $selection; do
                if [[ "$item" =~ ^[0-9]+$ ]]; then
                    # Single number
                    idx=$((item - 1))
                    if [ $idx -ge 0 ] && [ $idx -lt ${#COMMANDS[@]} ]; then
                        selected_indices+=($idx)
                    else
                        print_warning "Number $item is out of range (1-${#COMMANDS[@]})"
                    fi
                elif [[ "$item" =~ ^[0-9]+-[0-9]+$ ]]; then
                    # Range
                    start=$(echo "$item" | cut -d'-' -f1)
                    end=$(echo "$item" | cut -d'-' -f2)
                    start_idx=$((start - 1))
                    end_idx=$((end - 1))
                    
                    if [ $start_idx -ge 0 ] && [ $end_idx -lt ${#COMMANDS[@]} ] && [ $start_idx -le $end_idx ]; then
                        for ((j=start_idx; j<=end_idx; j++)); do
                            selected_indices+=($j)
                        done
                    else
                        print_warning "Range $item is invalid"
                    fi
                else
                    print_warning "Invalid input: $item"
                fi
            done
            ;;
    esac
    
    # Remove duplicates and sort
    if [ ${#selected_indices[@]} -gt 0 ]; then
        selected_indices=($(printf '%s\n' "${selected_indices[@]}" | sort -nu))
        break
    else
        print_warning "No valid commands selected. Please try again."
    fi
done

echo ""
print_status "Selected commands:"
selected_commands=()
for idx in "${selected_indices[@]}"; do
    IFS=':' read -r cmd desc danger_level <<< "${COMMANDS[$idx]}"
    selected_commands+=("$cmd")
    
    # Set colors and warning indicators based on danger level
    case "$danger_level" in
        "danger")
            cmd_color="$RED"
            warning_indicator="${RED}⚠️  DANGER${NC}"
            ;;
        "caution")
            cmd_color="$YELLOW"
            warning_indicator="${YELLOW}⚠️  CAUTION${NC}"
            ;;
        *)
            cmd_color="$GREEN"
            warning_indicator=""
            ;;
    esac
    
    # Display selected command with appropriate colors and warnings
    if [ -n "$warning_indicator" ]; then
        printf "  ${cmd_color}%-12s${NC} - %s ${warning_indicator}\n" "$cmd" "$desc"
    else
        printf "  ${cmd_color}%-12s${NC} - %s\n" "$cmd" "$desc"
    fi
done

echo ""
read -p "Proceed with allowing these commands globally? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_warning "Operation cancelled."
    exit 0
fi

echo ""
print_status "Setting up global permissions..."

# Get current Claude config
CONFIG_DIR="$HOME/.config/claude-code"
CONFIG_FILE="$CONFIG_DIR/settings.json"

# Create config directory if it doesn't exist
if [ ! -d "$CONFIG_DIR" ]; then
    mkdir -p "$CONFIG_DIR"
fi

# Create or update settings.json
if [ -f "$CONFIG_FILE" ]; then
    print_status "Updating existing config file..."
    # Backup existing config
    cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    print_status "Backup created: $CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
else
    print_status "Creating new config file..."
    echo '{}' > "$CONFIG_FILE"
fi

# Build the allowedTools array
allowed_tools_json=""
for cmd in "${selected_commands[@]}"; do
    if [ -n "$allowed_tools_json" ]; then
        allowed_tools_json="$allowed_tools_json, "
    fi
    allowed_tools_json="$allowed_tools_json\"Bash($cmd:*)\""
done

# Use jq to update the config if available, otherwise use a simple approach
if command_exists jq; then
    print_status "Using jq to update configuration..."
    temp_file=$(mktemp)
    jq --argjson tools "[$allowed_tools_json]" '.allowedTools = $tools' "$CONFIG_FILE" > "$temp_file"
    mv "$temp_file" "$CONFIG_FILE"
else
    print_status "Updating configuration manually..."
    # Simple JSON update without jq
    temp_file=$(mktemp)
    
    # Read existing config and add/update allowedTools
    if grep -q "allowedTools" "$CONFIG_FILE"; then
        # Replace existing allowedTools
        sed "s/\"allowedTools\":\s*\[[^]]*\]/\"allowedTools\": [$allowed_tools_json]/g" "$CONFIG_FILE" > "$temp_file"
    else
        # Add allowedTools to existing JSON
        sed 's/{\s*}/{"allowedTools": ['"$allowed_tools_json"']}/g' "$CONFIG_FILE" | \
        sed 's/}\s*$/,\n  "allowedTools": ['"$allowed_tools_json"']\n}/g' > "$temp_file"
    fi
    
    mv "$temp_file" "$CONFIG_FILE"
fi

# Verify the configuration was updated
if grep -q "allowedTools" "$CONFIG_FILE"; then
    print_success "Configuration updated successfully!"
    echo ""
    print_status "Updated config file: $CONFIG_FILE"
    echo ""
    print_status "Allowed commands:"
    for cmd in "${selected_commands[@]}"; do
        printf "  ${GREEN}✓${NC} Bash(%s:*)\n" "$cmd"
    done
else
    print_error "Failed to update configuration. Please check manually."
    exit 1
fi

echo ""
echo "=================================================="
echo "              Setup Complete                      "
echo "=================================================="
echo ""

print_success "Global permissions have been configured!"
echo ""
echo "Selected commands will now be automatically allowed in Claude Code CLI:"
for cmd in "${selected_commands[@]}"; do
    printf "  ${GREEN}✓${NC} %s\n" "$cmd"
done

echo ""
echo "Note: These permissions apply globally across all Claude Code sessions."
echo "To modify permissions later, you can:"
echo "1. Run this script again"
echo "2. Manually edit: $CONFIG_FILE"
echo "3. Use claude config commands"
echo ""

# Make script executable
if [ -f "./setup-permissions.sh" ]; then
    chmod +x ./setup-permissions.sh
fi
print_status "Script has been made executable for future use."

echo ""
print_status "Next time you use Claude Code CLI, these commands won't require permission prompts!"