#!/bin/bash

# Claude Code Studio - Config Restore Script
# Cross-platform restore functionality for Claude Code (CLI) configurations
# Allows easy restoration of any previous configuration backup

set +e  # Don't exit on error immediately

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

# Project paths
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIGS_DIR="$SCRIPT_DIR/configs"
CURRENT_CONFIG="$CONFIGS_DIR/settings.json"

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

print_restore() {
    printf "${MAGENTA}[RESTORE]${NC} %s\n" "$1"
}

print_backup() {
    printf "${CYAN}[BACKUP]${NC} %s\n" "$1"
}

# Function to find Claude config file
find_claude_config() {
    local config_dir="$1"
    
    # Check if directory exists
    if [ ! -d "$config_dir" ]; then
        return 1
    fi
    
    # List of possible config names in order of likelihood
    local config_names=(
        "settings.json"
        "config.json"
        "claude_code_config.json"
        ".claude.json"
    )
    
    # Check each possible name
    for name in "${config_names[@]}"; do
        if [ -f "$config_dir/$name" ]; then
            echo "$config_dir/$name"
            return 0
        fi
    done
    
    # If no standard name found, look for any .json file
    local json_files=("$config_dir"/*.json)
    if [ -f "${json_files[0]}" ]; then
        echo "${json_files[0]}"
        return 0
    fi
    
    return 1
}

# Function to create backup before restore
create_pre_restore_backup() {
    local source_file="$1"
    
    if [ ! -f "$source_file" ]; then
        return 1
    fi
    
    # Get the base name of the config file
    local base_name=$(basename "$source_file" .json)
    
    # Create timestamp
    local timestamp=$(date +"%Y-%m-%d_%H%M%S")
    
    # Create backup filename
    local backup_file="$CONFIGS_DIR/${base_name}_${timestamp}_pre_restore.json"
    
    # Copy the file
    cp "$source_file" "$backup_file"
    
    print_backup "Pre-restore backup created: $(basename "$backup_file")"
    
    return 0
}

# Detect OS and set config directory for Claude Code (CLI)
OS_TYPE="unknown"
CONFIG_DIR=""

if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macOS"
    CONFIG_DIR="$HOME/.config/claude-code"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="Linux"
    CONFIG_DIR="$HOME/.config/claude-code"
    # Check if running in WSL
    if grep -qi microsoft /proc/version 2>/dev/null; then
        OS_TYPE="WSL2/Linux"
    fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS_TYPE="Windows"
    CONFIG_DIR="$HOME/.config/claude-code"
    if [ -z "$HOME" ]; then
        CONFIG_DIR="$USERPROFILE/.config/claude-code"
    fi
else
    print_warning "Unknown OS. Please manually configure Claude Code."
    CONFIG_DIR=""
fi

# Find the actual config file location
EXISTING_CONFIG=false
ORIGINAL_CONFIG_NAME=""
if [ -n "$CONFIG_DIR" ]; then
    CONFIG_PATH=$(find_claude_config "$CONFIG_DIR")
    if [ $? -eq 0 ] && [ -n "$CONFIG_PATH" ]; then
        EXISTING_CONFIG=true
        ORIGINAL_CONFIG_NAME=$(basename "$CONFIG_PATH")
        print_success "Found existing config: $ORIGINAL_CONFIG_NAME"
    else
        # Use default name if no config found
        CONFIG_PATH="$CONFIG_DIR/settings.json"
        ORIGINAL_CONFIG_NAME="settings.json"
        print_status "No existing config found. Will restore to: $ORIGINAL_CONFIG_NAME"
    fi
else
    print_error "Could not determine Claude Code config location."
    exit 1
fi

# Header
echo "================================================"
echo "    Claude Code Studio - Config Restore Tool    "
echo "         Restore Previous Configurations        "
echo "================================================"
echo ""
print_status "Operating System: $OS_TYPE"
print_status "Config location: $CONFIG_PATH"
echo ""

# Check if configs directory exists
if [ ! -d "$CONFIGS_DIR" ]; then
    print_error "No configs directory found. Run install.sh first to create backups."
    exit 1
fi

# Get list of backups
BACKUPS=($(ls -1 "$CONFIGS_DIR"/*.json 2>/dev/null | grep -v "claude_desktop_config.json$" | sort -r))

if [ ${#BACKUPS[@]} -eq 0 ]; then
    print_error "No backup files found in configs directory."
    exit 1
fi

# Display available backups
echo "================================================"
echo "            Available Backup Files              "
echo "================================================"
echo ""

# Create arrays for selection
declare -a BACKUP_NAMES
declare -a BACKUP_PATHS

# Add current config if it exists
if [ -f "$CURRENT_CONFIG" ]; then
    echo "  0) settings.json (current/latest)"
    BACKUP_NAMES[0]="settings.json"
    BACKUP_PATHS[0]="$CURRENT_CONFIG"
    START_INDEX=1
else
    START_INDEX=0
fi

# Process and display backups
INDEX=$START_INDEX
for backup in "${BACKUPS[@]}"; do
    BASENAME=$(basename "$backup")
    
    # Extract date and type from filename
    # Format: configname_YYYY-MM-DD_HHMMSS_type.json
    if [[ $BASENAME =~ ([^_]+)_([0-9]{4}-[0-9]{2}-[0-9]{2})_([0-9]{6})_([^.]+)\.json$ ]]; then
        CONFIG_NAME="${BASH_REMATCH[1]}"
        DATE="${BASH_REMATCH[2]}"
        TIME="${BASH_REMATCH[3]}"
        TYPE="${BASH_REMATCH[4]}"
        
        # Format time for display
        TIME_FORMATTED="${TIME:0:2}:${TIME:2:2}:${TIME:4:2}"
        
        # Color code by type
        case "$TYPE" in
            "before")
                TYPE_COLOR="${YELLOW}[before]${NC}"
                ;;
            "after")
                TYPE_COLOR="${GREEN}[after]${NC}"
                ;;
            "pre_restore")
                TYPE_COLOR="${CYAN}[pre-restore]${NC}"
                ;;
            *)
                TYPE_COLOR="[$TYPE]"
                ;;
        esac
        
        printf "  %s) %s %s %s - %s\n" "$INDEX" "$DATE" "$TIME_FORMATTED" "$TYPE_COLOR" "$CONFIG_NAME"
    else
        echo "  $INDEX) $BASENAME"
    fi
    
    BACKUP_NAMES[$INDEX]="$BASENAME"
    BACKUP_PATHS[$INDEX]="$backup"
    ((INDEX++))
done

echo ""
echo "================================================"
echo ""

# Ask user to select a backup
while true; do
    read -p "Select a backup to restore (0-$((INDEX-1)), or 'q' to quit): " SELECTION
    
    if [ "$SELECTION" = "q" ] || [ "$SELECTION" = "Q" ]; then
        print_warning "Restore cancelled."
        exit 0
    fi
    
    if [[ "$SELECTION" =~ ^[0-9]+$ ]] && [ "$SELECTION" -ge 0 ] && [ "$SELECTION" -lt "$INDEX" ]; then
        break
    else
        print_error "Invalid selection. Please enter a number between 0 and $((INDEX-1))."
    fi
done

# Get selected backup
SELECTED_BACKUP="${BACKUP_PATHS[$SELECTION]}"
SELECTED_NAME="${BACKUP_NAMES[$SELECTION]}"

echo ""
print_restore "Selected backup: $SELECTED_NAME"
echo ""

# Show preview of selected config
echo "================================================"
echo "              Config Preview (first 20 lines)   "
echo "================================================"
echo ""
head -20 "$SELECTED_BACKUP"
echo ""
echo "================================================"
echo ""

# Confirm restoration
read -p "Do you want to restore this configuration? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_warning "Restore cancelled."
    exit 0
fi

echo ""

# Create backup of current config before restoring
if [ "$EXISTING_CONFIG" = true ] && [ -f "$CONFIG_PATH" ]; then
    print_backup "Creating backup of current config before restore..."
    create_pre_restore_backup "$CONFIG_PATH"
    echo ""
fi

# Create config directory if it doesn't exist
mkdir -p "$(dirname "$CONFIG_PATH")"

# Restore the selected backup
print_restore "Restoring configuration..."
cp "$SELECTED_BACKUP" "$CONFIG_PATH"

if [ $? -eq 0 ]; then
    print_success "Configuration restored successfully!"
    echo ""
    echo "Restored to: $CONFIG_PATH"
    echo "From backup: $SELECTED_NAME"
else
    print_error "Failed to restore configuration."
    exit 1
fi

echo ""
echo "================================================"
echo "              Restore Complete                  "
echo "================================================"
echo ""

echo "Next steps:"
echo "1. Restart Claude Code (CLI) to load the restored configuration"
echo "2. Check MCP server status with: claude-code --mcp-list"
echo ""

if [ "$EXISTING_CONFIG" = true ]; then
    echo "Note: Your previous config was backed up with suffix '_pre_restore'"
    echo "You can restore it later if needed."
fi

echo ""
print_status "Restore operation completed successfully!"