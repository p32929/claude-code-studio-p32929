# MCP - Model Context Protocol Server Configuration & Integration

## INSTALLATION GUIDE

### Prerequisites
```bash
# Install Node.js 18+ and npm
# Install Claude Desktop application
# Ensure git is configured
```

### MCP Server Installation

#### 1. Core Development Servers
```bash
# Git MCP Server - Version control operations
npm install -g @modelcontextprotocol/server-git
# or
npx -y @modelcontextprotocol/server-git

# Serena - Code analysis and refactoring
npm install -g @modelcontextprotocol/server-serena

# IDE - VS Code integration (if using VS Code)
# Install via VS Code extension marketplace: "MCP Server for VS Code"
```

#### 2. Documentation Servers
```bash
# Context7 - Documentation management
npm install -g @modelcontextprotocol/server-context7

# Sequential Thinking - Complex analysis
npm install -g @modelcontextprotocol/server-sequential-thinking
```

#### 3. Testing Servers
```bash
# Playwright - E2E testing
npm install -g @modelcontextprotocol/server-playwright
# Also install Playwright browsers:
npx playwright install

# Puppeteer - Browser automation
npm install -g @modelcontextprotocol/server-puppeteer
```


### Claude Desktop Configuration

Add to your Claude Desktop config file (`~/Library/Application Support/Claude/claude_desktop_config.json` on macOS):

```json
{
  "mcpServers": {
    "git": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-git"]
    },
    "serena": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-serena"]
    },
    "ide": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-ide"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-context7"]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
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
```

### Environment Variables Setup

Most servers work without environment variables. Add API keys only when needed for specific projects.

### Verification

After installation, verify MCP servers are working:

```bash
# Test git server
npx @modelcontextprotocol/server-git --version

# Restart Claude Desktop to load new configuration
# Check MCP server status in Claude Desktop settings
```

## SERVER CATEGORIES
**Core Development**: git, serena, ide | **Documentation**: context7, sequential-thinking | **Testing**: playwright, puppeteer

## AGENT-MCP COORDINATION

### Utility Agent Delegations (MANDATORY)
- **file-creator**: File operations (Write, MultiEdit, Edit)
- **git-workflow**: Version control (git.git_commit, git.git_add, git.git_status)
- **knowledge-fetcher**: Research (context7, WebSearch)
- **date-checker**: Temporal calculations (date commands, filtering)
- **context-fetcher**: Documentation (Read, Glob, WebFetch)

### Specialized Agent Patterns
- **Testing**: test-writer-fixer → playwright/ide → validation
- **Code Analysis**: Engineering agents → serena/sequential-thinking → insights
- **Error Resolution**: backend-architect → debugging tools → diagnosis
- **Deployment**: devops-automator → git → custom deployment

## QUERY CLASSIFICATION RULES

### Task Type Detection
```yaml
simple_lookup:
  indicators: ["find", "get", "show", "list", "what is", "when did"]
  rule: "Use most direct tool, STOP after definitive answer"
  max_tools: 1-2
  
complex_analysis:
  indicators: ["analyze", "compare", "synthesize", "recommend", "explain why", "how should"]
  rule: "Multi-tool coordination acceptable, sequential-thinking encouraged"
  max_tools: 3-5
```

## ERROR RECOVERY & FALLBACKS
- **git** → Manual git commands → Note version control limitations  
- **context7** → WebSearch → Manual documentation lookup
- **sequential-thinking** → Native analysis → Note complexity limitations
- **puppeteer/playwright** → Manual testing → Provide test cases and fallback instructions
- **serena** → Text-based code analysis → Note semantic analysis limitations
- **ide** → Text-based diagnostics → Note development environment limitations

## ANTI-PATTERNS & USAGE WARNINGS

### Critical Avoid Conditions
- **browser_automation**: headless_server_environment, rate_limited_apis
- **git_operations**: detached_head_state
- **sequential_thinking**: simple_single_step_tasks

### Performance Anti-Patterns
- **excessive_sequential_thinking_calls**: >3 calls per task
- **browser_automation_for_api_tasks**: Use direct API calls when available
- **unnecessary_tool_escalation**: Apply STOP rule from query classification

## PERFORMANCE OPTIMIZATION

### Stop Conditions
```yaml
stop_execution_when:
  query_answered: "Got definitive answer to user's specific question"
  token_threshold_reached: "simple_lookup: >1000 tokens, medium_analysis: >5000 tokens, complex_analysis: >15000 tokens"
  completion_criteria_met: "Task objectives fully satisfied"
  error_resolution_complete: "Problem identified and solution provided"
```

### Tool Performance Profiles
- **git_operations**: 50-200ms, minimal tokens, parallel_safe
- **browser_automation**: 800-5000ms, medium tokens, resource_intensive, NOT parallel_safe
- **sequential_thinking**: 1000-10000ms, high-very_high tokens, parallel_safe
- **serena_operations**: 100-2000ms, low-medium tokens, parallel_safe
- **context7_operations**: 200-5000ms, low-high tokens, parallel_safe
- **ide_operations**: 50-500ms, minimal tokens, parallel_safe

## MCP SERVER CAPABILITIES

### Git Server
**Tools Available**: git_status, git_diff, git_log, git_add, git_commit, git_push, git_pull, git_branch, git_checkout, git_merge
**Use Cases**: Version control, branch management, commit history, collaboration

### Serena Server
**Tools Available**: analyze_code, refactor_code, suggest_improvements, find_patterns, extract_functions
**Use Cases**: Code quality analysis, refactoring suggestions, pattern detection, architectural improvements

### IDE Server (VS Code)
**Tools Available**: get_diagnostics, execute_code, get_symbols, find_references, get_hover_info
**Use Cases**: Real-time error detection, code execution, symbol navigation, intelligent code assistance

### Context7 Server
**Tools Available**: search_docs, index_content, retrieve_context, manage_knowledge
**Use Cases**: Documentation search, knowledge management, context retrieval, information organization


### Sequential Thinking Server
**Tools Available**: analyze_complex, break_down_problem, synthesize_solution, evaluate_options
**Use Cases**: Complex problem solving, multi-step analysis, decision trees, strategic planning

### Playwright Server
**Tools Available**: run_tests, generate_tests, debug_tests, record_actions, take_screenshots
**Use Cases**: E2E testing, browser automation, visual regression, user flow validation

### Puppeteer Server
**Tools Available**: navigate_page, click_element, type_text, take_screenshot, generate_pdf, evaluate_script
**Use Cases**: Web scraping, PDF generation, automated testing, browser control

## TROUBLESHOOTING

### Common Installation Issues

#### NPM Permission Errors
```bash
# Fix npm permissions
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

#### MCP Server Not Found
```bash
# Verify installation
npm list -g | grep @modelcontextprotocol

# Reinstall if needed
npm install -g @modelcontextprotocol/server-[name]
```

#### Claude Desktop Not Loading Servers
1. Check config file syntax (valid JSON)
2. Restart Claude Desktop completely
3. Check logs: `~/Library/Logs/Claude/`
4. Verify server paths are correct

#### Environment Variables Not Working
1. Ensure variables are exported in shell
2. Add to Claude Desktop config directly
3. Check for typos in variable names
4. Verify API keys are valid

### Server-Specific Issues

#### Playwright/Puppeteer Not Working
- Install browser binaries: `npx playwright install`
- Check system dependencies: `npx playwright install-deps`
- Verify headless mode compatibility