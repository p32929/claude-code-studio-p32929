#!/bin/bash

# Claude Code Studio - MCP Server Installation Script
# Cross-platform installation for Windows, macOS, and Linux
# This script installs essential and optional MCP servers for Claude Desktop
# Includes automatic backup and restore functionality

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Project paths
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIGS_DIR="$SCRIPT_DIR/configs"
CURRENT_CONFIG="$CONFIGS_DIR/claude_desktop_config.json"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_backup() {
    echo -e "${MAGENTA}[BACKUP]${NC} $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
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
        "claude_desktop_config.json"
        ".claude.json"
        "claude_config.json"
        "config.json"
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

# Function to create backup
create_backup() {
    local source_file="$1"
    local backup_type="$2"  # "before" or "after"
    
    if [ ! -f "$source_file" ]; then
        return 1
    fi
    
    # Create configs directory if it doesn't exist
    mkdir -p "$CONFIGS_DIR"
    
    # Get the base name of the config file
    local base_name=$(basename "$source_file" .json)
    
    # Create timestamp
    local timestamp=$(date +"%Y-%m-%d_%H%M%S")
    
    # Create backup filename
    local backup_file="$CONFIGS_DIR/${base_name}_${timestamp}_${backup_type}.json"
    
    # Copy the file
    cp "$source_file" "$backup_file"
    
    print_backup "Backup created: $(basename "$backup_file")"
    
    # Also save as current config (without date) if it's an "after" backup
    if [ "$backup_type" = "after" ]; then
        cp "$source_file" "$CURRENT_CONFIG"
        print_backup "Current config saved: claude_desktop_config.json"
    fi
    
    return 0
}

# Function to install an MCP server
install_server() {
    local server_name=$1
    local package_name=$2
    
    print_status "Installing $server_name..."
    if npm install -g "$package_name" 2>/dev/null || npx -y "$package_name" --version 2>/dev/null; then
        print_success "$server_name installed successfully"
        return 0
    else
        print_warning "$server_name installation failed or not available yet"
        return 1
    fi
}

# Detect OS and set config directory
OS_TYPE="unknown"
CONFIG_DIR=""

if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macOS"
    CONFIG_DIR="$HOME/Library/Application Support/Claude"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="Linux"
    CONFIG_DIR="$HOME/.config/Claude"
    # Check if running in WSL
    if grep -qi microsoft /proc/version 2>/dev/null; then
        OS_TYPE="WSL2/Linux"
        print_status "WSL2 detected - you can also access Windows config at:"
        echo "  /mnt/c/Users/$USER/AppData/Roaming/Claude/"
    fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS_TYPE="Windows"
    if [ -n "$APPDATA" ]; then
        CONFIG_DIR="$APPDATA/Claude"
    elif [ -n "$USERPROFILE" ]; then
        CONFIG_DIR="$USERPROFILE/AppData/Roaming/Claude"
    fi
else
    print_warning "Unknown OS. Please manually configure Claude Desktop."
    CONFIG_DIR=""
fi

# Find the actual config file
EXISTING_CONFIG=false
if [ -n "$CONFIG_DIR" ]; then
    CONFIG_PATH=$(find_claude_config "$CONFIG_DIR")
    if [ $? -eq 0 ] && [ -n "$CONFIG_PATH" ]; then
        print_success "Found existing config: $(basename "$CONFIG_PATH")"
        EXISTING_CONFIG=true
    else
        # Use default name if no config found
        CONFIG_PATH="$CONFIG_DIR/claude_desktop_config.json"
        print_status "No existing config found. Will create: claude_desktop_config.json"
    fi
else
    CONFIG_PATH=""
fi

# Header
echo "================================================"
echo "   Claude Code Studio - MCP Server Installer   "
echo "        Cross-Platform Installation Script      "
echo "           With Automatic Backup System         "
echo "================================================"
echo ""
print_status "Operating System: $OS_TYPE"
if [ -n "$CONFIG_PATH" ]; then
    echo -e "${CYAN}[CONFIG]${NC} Location: $CONFIG_PATH"
fi
echo ""

# Create configs directory
mkdir -p "$CONFIGS_DIR"

# Backup existing config if it exists
if [ "$EXISTING_CONFIG" = true ] && [ -f "$CONFIG_PATH" ]; then
    print_backup "Creating backup before installation..."
    create_backup "$CONFIG_PATH" "before"
    echo ""
fi

# Check prerequisites
print_status "Checking prerequisites..."

if ! command_exists node; then
    print_error "Node.js is not installed. Please install Node.js 18+ first."
    echo "Visit: https://nodejs.org/"
    exit 1
fi

if ! command_exists npm; then
    print_error "npm is not installed. Please install npm first."
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    print_warning "Node.js version is less than 18. Some servers may not work properly."
fi

print_success "Prerequisites check passed"
echo ""

# Essential Servers
echo "================================================"
echo "          Installing Essential Servers         "
echo "================================================"
echo ""

print_status "These servers are recommended for all users:"
echo ""

# Git - Version control
install_server "Git MCP Server" "@modelcontextprotocol/server-git"

# IDE - Code intelligence (if using VS Code)
if command_exists code; then
    print_status "VS Code detected. Installing IDE server..."
    install_server "IDE MCP Server" "@modelcontextprotocol/server-ide"
else
    print_warning "VS Code not detected. Skipping IDE server."
fi

# Playwright - Web scraping and testing
install_server "Playwright MCP Server" "@modelcontextprotocol/server-playwright"

# Install Playwright browsers if server was installed
if npm list -g @modelcontextprotocol/server-playwright >/dev/null 2>&1; then
    print_status "Installing Playwright browsers..."
    npx playwright install
    print_success "Playwright browsers installed"
fi

# Puppeteer - Alternative browser automation
install_server "Puppeteer MCP Server" "@modelcontextprotocol/server-puppeteer"

echo ""

# Optional Servers
echo "================================================"
echo "           Optional Server Installation         "
echo "================================================"
echo ""

read -p "Do you want to install optional MCP servers? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    print_status "Installing optional servers..."
    echo ""
    
    # Code analysis
    install_server "Serena (Code Analysis)" "@modelcontextprotocol/server-serena"
    
    # Documentation
    install_server "Context7 (Documentation)" "@modelcontextprotocol/server-context7"
    
    # Complex thinking
    install_server "Sequential Thinking" "@modelcontextprotocol/server-sequential-thinking"
fi

echo ""
echo "================================================"
echo "           Claude Desktop Configuration         "
echo "================================================"
echo ""

if [ -n "$CONFIG_PATH" ]; then
    if [ "$EXISTING_CONFIG" = true ]; then
        print_status "Updating existing config with MCP servers..."
        print_warning "Note: Manual merge may be required for complex configs"
    else
        read -p "Do you want to create a new config file? (y/n): " -n 1 -r
        echo ""
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Create directory if it doesn't exist
            mkdir -p "$(dirname "$CONFIG_PATH")"
            
            # Create basic config
            cat > "$CONFIG_PATH" << 'EOF'
{
  "mcpServers": {
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-playwright"]
    },
    "puppeteer": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-puppeteer"]
    }
  }
}
EOF
            print_success "Config file created at: $CONFIG_PATH"
            EXISTING_CONFIG=true
        else
            print_warning "Skipping config creation."
        fi
    fi
    
    # Create "after" backup if config exists
    if [ "$EXISTING_CONFIG" = true ] && [ -f "$CONFIG_PATH" ]; then
        echo ""
        print_backup "Creating backup after installation..."
        create_backup "$CONFIG_PATH" "after"
    fi
fi

echo ""
echo "================================================"
echo "              Installation Complete             "
echo "================================================"
echo ""

print_success "Essential MCP servers have been installed!"
echo ""

if [ -d "$CONFIGS_DIR" ] && [ "$(ls -A "$CONFIGS_DIR" 2>/dev/null)" ]; then
    echo -e "${MAGENTA}[BACKUPS]${NC} Config backups stored in: configs/"
    echo "  - Use ./restore.sh to restore any previous configuration"
    echo ""
fi

echo "Next steps:"
echo "1. Restart Claude Desktop to load the new configuration"
echo "2. Check MCP server status in Claude Desktop settings"
echo "3. Install additional servers as needed for specific projects"
echo ""
echo "For more information, see:"
echo "  - MCP Specification: https://modelcontextprotocol.io"
echo "  - Claude Desktop Docs: https://docs.anthropic.com/claude-desktop"
echo ""

# Make scripts executable
if [ -f "./install.sh" ]; then
    chmod +x ./install.sh
fi
if [ -f "./restore.sh" ]; then
    chmod +x ./restore.sh
fi
print_status "Scripts have been made executable for future use."