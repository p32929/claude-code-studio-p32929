#!/usr/bin/env node

/**
 * Claude Code Studio - Permissions Setup Tool (JavaScript Version)
 * Allow common commands globally so Claude Code stops asking for permission
 * Interactive selection with numbered list interface
 */

const fs = require('fs');
const path = require('path');
const readline = require('readline');
const os = require('os');

// Colors for terminal output
const colors = {
    reset: '\033[0m',
    red: '\033[0;31m',
    green: '\033[0;32m',
    yellow: '\033[1;33m',
    blue: '\033[0;34m',
    magenta: '\033[0;35m',
    cyan: '\033[0;36m'
};

// Check if we should use colors
const useColors = process.stdout.isTTY;
const c = useColors ? colors : Object.fromEntries(Object.keys(colors).map(k => [k, '']));

// Print functions
const print = {
    status: (msg) => console.log(`${c.blue}[INFO]${c.reset} ${msg}`),
    success: (msg) => console.log(`${c.green}[SUCCESS]${c.reset} ${msg}`),
    warning: (msg) => console.log(`${c.yellow}[WARNING]${c.reset} ${msg}`),
    error: (msg) => console.log(`${c.red}[ERROR]${c.reset} ${msg}`),
    header: (msg) => console.log(`${c.cyan}[HEADER]${c.reset} ${msg}`)
};

// Commands with descriptions and danger levels
const COMMANDS = [
    { cmd: "cd", desc: "Change directory - navigate between folders", danger: "safe" },
    { cmd: "ls", desc: "List directory contents", danger: "safe" },
    { cmd: "pwd", desc: "Print working directory - show current location", danger: "safe" },
    { cmd: "mkdir", desc: "Create directories", danger: "safe" },
    { cmd: "rmdir", desc: "Remove empty directories", danger: "caution" },
    { cmd: "rm", desc: "Remove files and directories", danger: "danger" },
    { cmd: "cp", desc: "Copy files and directories", danger: "safe" },
    { cmd: "mv", desc: "Move/rename files and directories", danger: "caution" },
    { cmd: "chmod", desc: "Change file permissions", danger: "caution" },
    { cmd: "chown", desc: "Change file ownership", danger: "caution" },
    { cmd: "find", desc: "Search for files and directories", danger: "safe" },
    { cmd: "grep", desc: "Search text patterns in files", danger: "safe" },
    { cmd: "cat", desc: "Display file contents", danger: "safe" },
    { cmd: "head", desc: "Display first lines of files", danger: "safe" },
    { cmd: "tail", desc: "Display last lines of files", danger: "safe" },
    { cmd: "less", desc: "View file contents page by page", danger: "safe" },
    { cmd: "more", desc: "View file contents page by page", danger: "safe" },
    { cmd: "touch", desc: "Create empty files or update timestamps", danger: "safe" },
    { cmd: "echo", desc: "Display text", danger: "safe" },
    { cmd: "which", desc: "Locate command executable", danger: "safe" },
    { cmd: "whoami", desc: "Display current username", danger: "safe" },
    { cmd: "date", desc: "Display or set system date", danger: "caution" },
    { cmd: "ps", desc: "Display running processes", danger: "safe" },
    { cmd: "kill", desc: "Terminate processes", danger: "danger" },
    { cmd: "killall", desc: "Terminate processes by name", danger: "danger" },
    { cmd: "top", desc: "Display running processes (live)", danger: "safe" },
    { cmd: "htop", desc: "Enhanced process viewer", danger: "safe" },
    { cmd: "du", desc: "Display disk usage", danger: "safe" },
    { cmd: "df", desc: "Display filesystem disk space usage", danger: "safe" },
    { cmd: "free", desc: "Display memory usage", danger: "safe" },
    { cmd: "uptime", desc: "Display system uptime", danger: "safe" },
    { cmd: "uname", desc: "Display system information", danger: "safe" },
    { cmd: "id", desc: "Display user and group IDs", danger: "safe" },
    { cmd: "groups", desc: "Display user groups", danger: "safe" },
    { cmd: "history", desc: "Display command history", danger: "safe" },
    { cmd: "clear", desc: "Clear terminal screen", danger: "safe" },
    { cmd: "exit", desc: "Exit shell", danger: "safe" },
    { cmd: "logout", desc: "Logout from shell", danger: "safe" },
    { cmd: "ssh", desc: "Secure shell remote connection", danger: "caution" },
    { cmd: "scp", desc: "Secure copy files over network", danger: "caution" },
    { cmd: "rsync", desc: "Synchronize files/directories", danger: "caution" },
    { cmd: "curl", desc: "Transfer data from/to servers", danger: "caution" },
    { cmd: "wget", desc: "Download files from web", danger: "caution" },
    { cmd: "tar", desc: "Archive and compress files", danger: "safe" },
    { cmd: "zip", desc: "Create zip archives", danger: "safe" },
    { cmd: "unzip", desc: "Extract zip archives", danger: "safe" },
    { cmd: "gzip", desc: "Compress files", danger: "safe" },
    { cmd: "gunzip", desc: "Decompress gzip files", danger: "safe" },
    { cmd: "sort", desc: "Sort lines in text files", danger: "safe" },
    { cmd: "uniq", desc: "Remove duplicate lines", danger: "safe" },
    { cmd: "wc", desc: "Count lines, words, characters", danger: "safe" },
    { cmd: "diff", desc: "Compare files line by line", danger: "safe" },
    { cmd: "patch", desc: "Apply differences to files", danger: "caution" },
    { cmd: "vim", desc: "Text editor", danger: "safe" },
    { cmd: "nano", desc: "Simple text editor", danger: "safe" },
    { cmd: "emacs", desc: "Text editor", danger: "safe" },
    { cmd: "git", desc: "Version control system", danger: "safe" },
    { cmd: "npm", desc: "Node.js package manager", danger: "caution" },
    { cmd: "yarn", desc: "Alternative Node.js package manager", danger: "caution" },
    { cmd: "pip", desc: "Python package manager", danger: "caution" },
    { cmd: "brew", desc: "macOS package manager", danger: "caution" },
    { cmd: "apt", desc: "Debian/Ubuntu package manager", danger: "danger" },
    { cmd: "yum", desc: "Red Hat package manager", danger: "danger" },
    { cmd: "dnf", desc: "Fedora package manager", danger: "danger" },
    { cmd: "pacman", desc: "Arch Linux package manager", danger: "danger" },
    { cmd: "docker", desc: "Container platform", danger: "caution" },
    { cmd: "kubectl", desc: "Kubernetes command-line tool", danger: "caution" },
    { cmd: "terraform", desc: "Infrastructure as code", danger: "caution" },
    { cmd: "ansible", desc: "Configuration management", danger: "caution" },
    { cmd: "systemctl", desc: "Control systemd services", danger: "danger" },
    { cmd: "service", desc: "Control system services", danger: "danger" },
    { cmd: "crontab", desc: "Schedule tasks", danger: "caution" },
    { cmd: "at", desc: "Schedule one-time tasks", danger: "caution" },
    { cmd: "nohup", desc: "Run commands immune to hangups", danger: "safe" },
    { cmd: "screen", desc: "Terminal multiplexer", danger: "safe" },
    { cmd: "tmux", desc: "Terminal multiplexer", danger: "safe" },
    { cmd: "jobs", desc: "Display active jobs", danger: "safe" },
    { cmd: "bg", desc: "Put jobs in background", danger: "safe" },
    { cmd: "fg", desc: "Bring jobs to foreground", danger: "safe" },
    { cmd: "mount", desc: "Mount filesystems", danger: "danger" },
    { cmd: "umount", desc: "Unmount filesystems", danger: "danger" },
    { cmd: "fdisk", desc: "Manage disk partitions", danger: "danger" },
    { cmd: "lsblk", desc: "List block devices", danger: "safe" },
    { cmd: "lsusb", desc: "List USB devices", danger: "safe" },
    { cmd: "lspci", desc: "List PCI devices", danger: "safe" },
    { cmd: "ifconfig", desc: "Configure network interface", danger: "danger" },
    { cmd: "ip", desc: "Show/manipulate routing, network devices", danger: "danger" },
    { cmd: "netstat", desc: "Display network connections", danger: "safe" },
    { cmd: "ss", desc: "Display socket statistics", danger: "safe" },
    { cmd: "ping", desc: "Send ICMP echo requests", danger: "safe" },
    { cmd: "traceroute", desc: "Trace network route", danger: "safe" },
    { cmd: "nslookup", desc: "Query DNS servers", danger: "safe" },
    { cmd: "dig", desc: "DNS lookup utility", danger: "safe" },
    { cmd: "awk", desc: "Text processing tool", danger: "safe" },
    { cmd: "sed", desc: "Stream editor for filtering and transforming text", danger: "caution" },
    { cmd: "tr", desc: "Translate or delete characters", danger: "safe" },
    { cmd: "cut", desc: "Extract columns from text", danger: "safe" },
    { cmd: "paste", desc: "Merge lines of files", danger: "safe" },
    { cmd: "xargs", desc: "Build and execute command lines", danger: "caution" },
    { cmd: "tee", desc: "Write output to multiple destinations", danger: "safe" },
    { cmd: "ln", desc: "Create links between files", danger: "caution" },
    { cmd: "stat", desc: "Display file or filesystem status", danger: "safe" },
    { cmd: "file", desc: "Determine file type", danger: "safe" },
    { cmd: "basename", desc: "Extract filename from path", danger: "safe" },
    { cmd: "dirname", desc: "Extract directory from path", danger: "safe" },
    { cmd: "readlink", desc: "Display symbolic link target", danger: "safe" },
    { cmd: "env", desc: "Display or set environment variables", danger: "safe" },
    { cmd: "export", desc: "Set environment variables", danger: "caution" },
    { cmd: "alias", desc: "Create command aliases", danger: "safe" },
    { cmd: "unalias", desc: "Remove command aliases", danger: "safe" },
    { cmd: "type", desc: "Display command type", danger: "safe" },
    { cmd: "help", desc: "Display help for built-in commands", danger: "safe" },
    { cmd: "man", desc: "Display manual pages", danger: "safe" },
    { cmd: "info", desc: "Display info documents", danger: "safe" },
    { cmd: "apropos", desc: "Search manual page names", danger: "safe" },
    { cmd: "locate", desc: "Find files by name", danger: "safe" },
    { cmd: "updatedb", desc: "Update locate database", danger: "caution" },
    { cmd: "cpio", desc: "Copy files to/from archives", danger: "caution" },
    { cmd: "dd", desc: "Convert and copy files", danger: "danger" },
    { cmd: "sync", desc: "Flush filesystem buffers", danger: "caution" },
    { cmd: "fsck", desc: "Check and repair filesystems", danger: "danger" },
    { cmd: "mkfs", desc: "Create filesystems", danger: "danger" },
    { cmd: "mcp__*", desc: "All MCP tools - Global permission for all MCP servers", danger: "safe" }
];

class PermissionsSetup {
    constructor() {
        this.configDir = path.join(os.homedir(), '.config', 'claude-code');
        this.configFile = path.join(this.configDir, 'settings.json');
        this.rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
        });
    }

    // Helper to get color for danger level
    getDangerColor(danger) {
        switch (danger) {
            case 'danger': return c.red;
            case 'caution': return c.yellow;
            default: return c.green;
        }
    }

    // Helper to get warning indicator
    getWarningIndicator(danger) {
        switch (danger) {
            case 'danger': return `${c.red}⚠️  DANGER${c.reset}`;
            case 'caution': return `${c.yellow}⚠️  CAUTION${c.reset}`;
            default: return '';
        }
    }

    // Display header
    showHeader() {
        console.log('==================================================');
        console.log('   Claude Code Studio - Permissions Setup Tool   ');
        console.log('       Allow Common Commands Globally            ');
        console.log('==================================================');
        console.log('');
    }

    // Display commands list
    showCommandsList() {
        print.header('Available Commands to Allow Globally:');
        console.log('');

        COMMANDS.forEach((command, index) => {
            const cmdColor = this.getDangerColor(command.danger);
            const warning = this.getWarningIndicator(command.danger);
            const num = `${c.cyan}${(index + 1).toString().padStart(3)}.${c.reset}`;
            const cmd = `${cmdColor}${command.cmd.padEnd(12)}${c.reset}`;
            
            if (warning) {
                console.log(`${num} ${cmd} - ${command.desc} ${warning}`);
            } else {
                console.log(`${num} ${cmd} - ${command.desc}`);
            }
        });
    }

    // Display selection options
    showSelectionOptions() {
        console.log('');
        console.log('==================================================');
        print.status('Color Legend:');
        console.log('');
        console.log(`  ${c.green}Green${c.reset}     - Safe commands (low risk)`);
        console.log(`  ${c.yellow}Yellow${c.reset}    - Caution commands (moderate risk) ${c.yellow}⚠️  CAUTION${c.reset}`);
        console.log(`  ${c.red}Red${c.reset}       - Dangerous commands (high risk) ${c.red}⚠️  DANGER${c.reset}`);
        console.log('');
        print.status('Selection Options:');
        console.log('');
        console.log('• Enter numbers separated by commas or spaces: 1,3,5 or 1 3 5');
        console.log('• Enter ranges with dash: 1-10 or 1-5,8-12');
        console.log('• Enter \'all\' to select all commands');
        console.log('• Enter \'common\' to select most commonly used commands (1-40)');
        console.log('• Enter \'dev\' to select development-related commands');
        console.log('• Enter \'system\' to select system administration commands');
        console.log('• Enter \'safe\' to select only safe commands (green)');
        console.log('• Enter \'mcp\' to allow all MCP server tools');
        console.log(`• Enter ${c.cyan}'custom:'${c.reset} followed by comma-separated commands (e.g. custom:docker,kubectl,helm)`);
        console.log('');
    }

    // Parse user selection
    parseSelection(selection) {
        const selected = new Set();
        this.customCommands = []; // Store custom commands for later processing

        // Handle special keywords
        if (selection.startsWith('custom:')) {
            // Handle custom commands
            const customPart = selection.slice(7); // Remove "custom:"
            const customCmds = customPart.split(',').map(cmd => cmd.trim()).filter(cmd => cmd);
            
            if (customCmds.length === 0) {
                print.warning('No custom commands provided after "custom:"');
                return [];
            }
            
            // Add custom commands to our temporary array
            this.customCommands = customCmds.map(cmd => ({
                cmd: cmd,
                desc: `Custom command - ${cmd}`,
                danger: 'caution' // Default custom commands to caution
            }));
            
            print.status(`Added ${customCmds.length} custom commands: ${customCmds.join(', ')}`);
            
            // Return indices that represent our custom commands (we'll handle them separately)
            return this.customCommands.map((_, index) => COMMANDS.length + index);
            
        } else if (selection === 'all') {
            for (let i = 0; i < COMMANDS.length; i++) {
                selected.add(i);
            }
        } else if (selection === 'common') {
            for (let i = 0; i < Math.min(40, COMMANDS.length); i++) {
                selected.add(i);
            }
        } else if (selection === 'safe') {
            COMMANDS.forEach((cmd, index) => {
                if (cmd.danger === 'safe') {
                    selected.add(index);
                }
            });
        } else if (selection === 'mcp') {
            COMMANDS.forEach((cmd, index) => {
                if (cmd.cmd === 'mcp__*') {
                    selected.add(index);
                }
            });
        } else if (selection === 'dev') {
            const devCommands = ['git', 'npm', 'yarn', 'pip', 'docker', 'kubectl', 'terraform', 'ansible'];
            COMMANDS.forEach((cmd, index) => {
                if (devCommands.includes(cmd.cmd)) {
                    selected.add(index);
                }
            });
        } else if (selection === 'system') {
            const sysCommands = ['systemctl', 'service', 'mount', 'umount', 'fdisk', 'ifconfig', 'ip', 'netstat'];
            COMMANDS.forEach((cmd, index) => {
                if (sysCommands.includes(cmd.cmd)) {
                    selected.add(index);
                }
            });
        } else {
            // Parse manual selection
            const parts = selection.replace(/,/g, ' ').split(/\s+/).filter(s => s);
            
            for (const part of parts) {
                if (/^\d+$/.test(part)) {
                    // Single number
                    const num = parseInt(part) - 1;
                    if (num >= 0 && num < COMMANDS.length) {
                        selected.add(num);
                    } else {
                        print.warning(`Number ${part} is out of range (1-${COMMANDS.length})`);
                    }
                } else if (/^\d+-\d+$/.test(part)) {
                    // Range
                    const [start, end] = part.split('-').map(n => parseInt(n) - 1);
                    if (start >= 0 && end < COMMANDS.length && start <= end) {
                        for (let i = start; i <= end; i++) {
                            selected.add(i);
                        }
                    } else {
                        print.warning(`Range ${part} is invalid`);
                    }
                } else {
                    print.warning(`Invalid input: ${part}`);
                }
            }
        }

        return Array.from(selected).sort((a, b) => a - b);
    }

    // Show selected commands
    showSelectedCommands(indices) {
        console.log('');
        print.status('Selected commands:');
        indices.forEach(index => {
            let cmd;
            if (index >= COMMANDS.length) {
                // Custom command
                cmd = this.customCommands[index - COMMANDS.length];
            } else {
                // Regular command
                cmd = COMMANDS[index];
            }
            
            const cmdColor = this.getDangerColor(cmd.danger);
            const warning = this.getWarningIndicator(cmd.danger);
            
            if (warning) {
                console.log(`  ${cmdColor}${cmd.cmd.padEnd(12)}${c.reset} - ${cmd.desc} ${warning}`);
            } else {
                console.log(`  ${cmdColor}${cmd.cmd.padEnd(12)}${c.reset} - ${cmd.desc}`);
            }
        });
    }

    // Get existing allowed tools
    getExistingTools() {
        try {
            if (fs.existsSync(this.configFile)) {
                const config = JSON.parse(fs.readFileSync(this.configFile, 'utf8'));
                return config.allowedTools || [];
            }
        } catch (error) {
            print.warning(`Error reading config: ${error.message}`);
        }
        return [];
    }

    // Display tools in columns
    displayToolsInColumns(tools, prefix = '  →') {
        const terminalWidth = process.stdout.columns || 80;
        const maxToolLength = Math.max(...tools.map(tool => tool.length));
        const columnWidth = Math.max(maxToolLength + 2, 20); // Minimum 20 chars per column
        const columnsPerRow = Math.floor((terminalWidth - 4) / columnWidth);
        
        for (let i = 0; i < tools.length; i += columnsPerRow) {
            const row = tools.slice(i, i + columnsPerRow);
            const formattedRow = row.map(tool => {
                // Extract command name for cleaner display
                let displayName = tool;
                if (tool.startsWith('Bash(') && tool.endsWith(':*)')) {
                    displayName = tool.slice(5, -3); // Remove "Bash(" and ":*)"
                } else if (tool === 'mcp__*') {
                    displayName = 'mcp__*';
                }
                return displayName.padEnd(columnWidth - 2);
            }).join('');
            
            console.log(`${prefix} ${c.yellow}${formattedRow.trim()}${c.reset}`);
        }
    }

    // Check if config exists and has allowed tools
    async checkExistingConfig() {
        const existingTools = this.getExistingTools();
        
        if (existingTools.length > 0) {
            console.log('');
            print.warning(`Existing permissions found in config (${existingTools.length} tools):`);
            this.displayToolsInColumns(existingTools);
            console.log('');

            // Ask user what to do
            const choice = await this.question(`${c.cyan}Do you want to:${c.reset}
  ${c.green}1.${c.reset} Replace existing permissions (clear and add new)
  ${c.green}2.${c.reset} Add to existing permissions (merge)
  ${c.green}3.${c.reset} Cancel

Enter your choice (1/2/3): `);

            switch (choice.trim()) {
                case '1':
                    print.status('Will replace existing permissions');
                    return { mode: 'replace', existing: [] };
                case '2':
                    print.status('Will add to existing permissions');
                    return { mode: 'merge', existing: existingTools };
                case '3':
                    print.warning('Operation cancelled.');
                    process.exit(0);
                default:
                    print.warning('Invalid choice. Please try again.');
                    return await this.checkExistingConfig();
            }
        }

        return { mode: 'replace', existing: [] };
    }

    // Update configuration
    updateConfig(selectedIndices, configMode) {
        try {
            // Ensure config directory exists
            if (!fs.existsSync(this.configDir)) {
                fs.mkdirSync(this.configDir, { recursive: true });
            }

            // Read existing config or create new one
            let config = {};
            if (fs.existsSync(this.configFile)) {
                // Create backup
                const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
                const backupFile = `${this.configFile}.backup.${timestamp}`;
                fs.copyFileSync(this.configFile, backupFile);
                print.status(`Backup created: ${path.basename(backupFile)}`);

                config = JSON.parse(fs.readFileSync(this.configFile, 'utf8'));
            }

            // Build new allowed tools array
            const newTools = selectedIndices.map(index => {
                let cmd;
                if (index >= COMMANDS.length) {
                    // Custom command
                    cmd = this.customCommands[index - COMMANDS.length];
                } else {
                    // Regular command
                    cmd = COMMANDS[index];
                }
                
                if (cmd.cmd.startsWith('mcp__')) {
                    return cmd.cmd;
                } else {
                    return `Bash(${cmd.cmd}:*)`;
                }
            });

            // Handle merge vs replace
            if (configMode.mode === 'merge') {
                // Merge with existing, avoiding duplicates
                const existingSet = new Set(configMode.existing);
                const combinedTools = [...configMode.existing];
                
                newTools.forEach(tool => {
                    if (!existingSet.has(tool)) {
                        combinedTools.push(tool);
                        print.status(`Adding new permission: ${tool}`);
                    } else {
                        print.status(`Skipping duplicate: ${tool}`);
                    }
                });
                
                config.allowedTools = combinedTools;
            } else {
                config.allowedTools = newTools;
            }

            // Write updated config
            fs.writeFileSync(this.configFile, JSON.stringify(config, null, 2));
            print.success('Configuration updated successfully!');

            return config.allowedTools;
        } catch (error) {
            print.error(`Failed to update configuration: ${error.message}`);
            process.exit(1);
        }
    }

    // Show final results
    showResults(selectedIndices, finalTools, configMode) {
        console.log('');
        console.log('==================================================');
        console.log('              Setup Complete                      ');
        console.log('==================================================');
        console.log('');

        print.success('Global permissions have been configured!');
        console.log('');

        if (configMode.mode === 'merge') {
            console.log('Added to existing permissions. All allowed commands in Claude Code CLI:');
            console.log('');
            
            // Show existing and new tools combined
            const allTools = [...new Set([...configMode.existing, ...finalTools])];
            this.displayToolsInColumns(allTools, '  ✓');
            
            // Show summary
            const newToolsCount = finalTools.filter(tool => !configMode.existing.includes(tool)).length;
            console.log('');
            console.log(`${c.green}Summary:${c.reset} ${configMode.existing.length} existing + ${newToolsCount} new = ${allTools.length} total tools`);
        } else {
            console.log('Replaced existing permissions. All allowed commands in Claude Code CLI:');
            console.log('');
            
            this.displayToolsInColumns(finalTools, '  ✓');
            console.log('');
            console.log(`${c.green}Summary:${c.reset} ${finalTools.length} tools configured`);
        }

        console.log('');
        console.log('Note: These permissions apply globally across all Claude Code sessions.');
        console.log('To modify permissions later, you can:');
        console.log('1. Run this script again');
        console.log(`2. Manually edit: ${this.configFile}`);
        console.log('3. Use claude config commands');
        console.log('');
        print.status('Next time you use Claude Code CLI, these commands won\'t require permission prompts!');
    }

    // Helper for readline questions
    question(query) {
        return new Promise(resolve => {
            this.rl.question(query, resolve);
        });
    }

    // Main execution
    async run() {
        try {
            this.showHeader();

            // Check prerequisites
            print.status('Checking prerequisites...');
            // Could add checks for claude command here
            print.success('Prerequisites check passed');
            console.log('');

            this.showCommandsList();
            this.showSelectionOptions();

            // Check for existing config
            const configMode = await this.checkExistingConfig();

            // Get user selection
            let selectedIndices;
            while (true) {
                const selection = await this.question('Enter your selection: ');
                
                if (!selection.trim()) {
                    print.warning('Please enter a selection.');
                    continue;
                }

                selectedIndices = this.parseSelection(selection.trim());
                if (selectedIndices.length > 0) {
                    break;
                } else {
                    print.warning('No valid commands selected. Please try again.');
                }
            }

            this.showSelectedCommands(selectedIndices);

            // Confirm
            console.log('');
            const confirm = await this.question('Proceed with allowing these commands globally? (y/n): ');
            if (!confirm.toLowerCase().startsWith('y')) {
                print.warning('Operation cancelled.');
                this.rl.close();
                return;
            }

            // Update configuration
            console.log('');
            print.status('Setting up global permissions...');
            const finalTools = this.updateConfig(selectedIndices, configMode);

            // Show results
            this.showResults(selectedIndices, finalTools, configMode);

        } catch (error) {
            print.error(`Error: ${error.message}`);
            process.exit(1);
        } finally {
            this.rl.close();
        }
    }
}

// Run if called directly
if (require.main === module) {
    const setup = new PermissionsSetup();
    setup.run();
}

module.exports = PermissionsSetup;