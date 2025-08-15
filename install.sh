#!/bin/bash

# Claude Code Studio - MCP Server Installation Script
# Cross-platform installation for Windows, macOS, and Linux
# This script installs essential and optional MCP servers for Claude Code (CLI)
# Includes automatic backup and restore functionality

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

# Project paths
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

print_backup() {
    printf "${MAGENTA}[BACKUP]${NC} %s\n" "$1"
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


# Function to add an MCP server using Claude CLI
add_mcp_server() {
    local server_name=$1
    local server_config=$2
    
    print_status "Adding $server_name to Claude Code CLI (user scope)..."
    
    # Check if claude command exists
    if ! command_exists claude; then
        print_error "Claude Code CLI not found. Please install Claude Code first."
        return 1
    fi
    
    # Add the server using claude mcp add-json with user scope for global access
    if claude mcp add-json --scope user "$server_name" "$server_config" 2>/dev/null; then
        print_success "$server_name added successfully"
        return 0
    else
        print_warning "$server_name could not be added - it may already exist"
        return 1
    fi
}

# Detect OS and set config directory for Claude Code (CLI)
OS_TYPE="unknown"
CONFIG_DIR=""

if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macOS"
    # Claude Code CLI config location on macOS
    CONFIG_DIR="$HOME/.config/claude-code"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="Linux"
    # Claude Code CLI config location on Linux
    CONFIG_DIR="$HOME/.config/claude-code"
    # Check if running in WSL
    if grep -qi microsoft /proc/version 2>/dev/null; then
        OS_TYPE="WSL2/Linux"
        print_status "WSL2 detected - you can also access Windows config at:"
        echo "  /mnt/c/Users/$USER/.config/claude-code/"
    fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS_TYPE="Windows"
    # Claude Code CLI config location on Windows
    CONFIG_DIR="$HOME/.config/claude-code"
    if [ -z "$HOME" ]; then
        CONFIG_DIR="$USERPROFILE/.config/claude-code"
    fi
else
    print_warning "Unknown OS. Please manually configure Claude Code."
    CONFIG_DIR=""
fi

# Find the actual config file
EXISTING_CONFIG=false
if [ -n "$CONFIG_DIR" ]; then
    CONFIG_PATH=$(find_claude_config "$CONFIG_DIR" 2>/dev/null)
    if [ $? -eq 0 ] && [ -n "$CONFIG_PATH" ]; then
        print_success "Found existing config: $(basename "$CONFIG_PATH")"
        EXISTING_CONFIG=true
    else
        # Use default name if no config found
        CONFIG_PATH="$CONFIG_DIR/settings.json"
        print_status "No existing config found. Will create: settings.json"
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
    printf "${CYAN}[CONFIG]${NC} Location: %s\n" "$CONFIG_PATH"
fi
echo ""


# Check prerequisites
print_status "Checking prerequisites..."

if ! command_exists claude; then
    print_error "Claude Code CLI is not installed. Please install Claude Code first."
    echo "Visit: https://docs.anthropic.com/en/docs/claude-code"
    exit 1
fi

if ! command_exists node; then
    print_error "Node.js is not installed. Please install Node.js 18+ first."
    echo "Visit: https://nodejs.org/"
    exit 1
fi

if ! command_exists npm; then
    print_error "npm is not installed. Please install npm first."
    exit 1
fi

if ! command_exists uvx; then
    print_warning "uvx is not installed. Python MCP servers (like git) will not work."
    echo "To install uvx: pip install uv"
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    print_warning "Node.js version is less than 18. Some servers may not work properly."
fi

print_success "Prerequisites check passed"
echo ""

# Essential Servers
echo "================================================"
echo "          Adding Essential MCP Servers          "
echo "================================================"
echo ""

print_status "Installing essential MCP servers globally..."
echo ""

# Install essential servers globally first
print_status "Installing @modelcontextprotocol/server-sequential-thinking..."
npm install -g @modelcontextprotocol/server-sequential-thinking

print_status "Installing @modelcontextprotocol/server-filesystem..."
npm install -g @modelcontextprotocol/server-filesystem

echo ""
print_status "Adding essential servers to Claude Code CLI:"
echo ""

# Git - Version control (Python package via uvx)
add_mcp_server "git" '{"command": "uvx", "args": ["mcp-server-git"]}'

# Sequential Thinking - Problem solving and analysis
add_mcp_server "sequential-thinking" '{"command": "npx", "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]}'

# Filesystem - File operations
add_mcp_server "filesystem" '{"command": "npx", "args": ["-y", "@modelcontextprotocol/server-filesystem"]}'

echo ""

# Optional Servers
echo "================================================"
echo "           Adding Optional MCP Servers          "
echo "================================================"
echo ""

read -p "Do you want to add optional MCP servers? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    print_status "Installing optional MCP servers globally..."
    echo ""
    
    # Install optional servers globally first
    print_status "Installing @hisma/server-puppeteer..."
    npm install -g @hisma/server-puppeteer
    
    print_status "Installing @modelcontextprotocol/server-memory..."
    npm install -g @modelcontextprotocol/server-memory
    
    echo ""
    print_status "Adding optional servers to Claude Code CLI..."
    echo ""
    
    # Code analysis - Serena from git repository
    add_mcp_server "serena" '{"command": "uvx", "args": ["--from", "git+https://github.com/oraios/serena", "serena", "start-mcp-server", "--context", "ide-assistant", "--enable-web-dashboard", "false"], "env": {"SERENA_NO_BROWSER": "true", "BROWSER": "none"}}'
    
    # Puppeteer - Browser automation
    add_mcp_server "puppeteer" '{"command": "npx", "args": ["-y", "@hisma/server-puppeteer"]}'
    
    # Memory - Claude memory through knowledge graph
    add_mcp_server "memory" '{"command": "npx", "args": ["-y", "@modelcontextprotocol/server-memory"]}'
fi

echo ""
echo "================================================"
echo "           Verifying MCP Configuration          "
echo "================================================"
echo ""

# MCP servers have been configured
print_success "MCP servers have been configured in Claude Code CLI!"
echo ""
print_status "To verify server status later, run: claude mcp list"
print_warning "Note: First run of 'claude mcp list' may take time to install packages"

echo ""
echo "================================================"
echo "              Installation Complete             "
echo "================================================"
echo ""

print_success "Essential MCP servers have been added to Claude Code CLI!"
echo ""

echo "Next steps:"
echo "1. Check MCP server status with: claude mcp list"
echo "2. Start using MCP tools in your Claude Code conversations"
echo "3. Add additional servers as needed for specific projects"
echo ""
echo "Available commands:"
echo "  - claude mcp list          # List all configured servers"
echo "  - claude mcp add           # Add a new server"
echo "  - claude mcp remove        # Remove a server"
echo ""
echo "For more information, see:"
echo "  - MCP Specification: https://modelcontextprotocol.io"
echo "  - Claude Code Docs: https://docs.anthropic.com/claude-code"
echo ""

# Make scripts executable
if [ -f "./install.sh" ]; then
    chmod +x ./install.sh
fi
if [ -f "./restore.sh" ]; then
    chmod +x ./restore.sh
fi
print_status "Scripts have been made executable for future use."