# CONTEXT - Project-Specific Configuration & Environment

## PROJECT OVERVIEW

### Repository Information
- **Project Name**: claude-code-studio-p32929
- **Primary Language**: TypeScript/JavaScript
- **Version Control**: Git (main branch)
- **AI Assistant**: Claude Opus 4.1 (claude-opus-4-1-20250805)

### Cross-Platform Development Environment
- **Operating Systems**: Windows 11, macOS, Linux (Ubuntu/WSL2)
- **Environment Detection**: Auto-detect using project language or shell commands
- **Platform-Specific Paths**:
  - **macOS**: `~/Library/Application Support/Claude/`
  - **Windows**: `%APPDATA%\Claude\` or `C:\Users\[username]\AppData\Roaming\Claude\`
  - **Linux**: `~/.config/Claude/`
  - **WSL2**: `/mnt/c/Users/[username]/` for Windows access

### Development Philosophy
- **Context-First Development**: Maximize context preservation across long conversations
- **Agent-Driven Workflows**: Leverage specialized agents for domain expertise
- **Evidence-Based Decisions**: All architectural choices backed by metrics and testing
- **Comprehensive Documentation**: Extensive is better than minimal
- **Best Practices Enforcement**: Follow industry standards automatically
- **Cross-Platform Compatibility**: Ensure all configurations work on Windows, macOS, and Linux

## TECHNOLOGY STACK

### Multi-Domain Development Stack

#### Web Development
- **Frontend**: React, TypeScript, Next.js, Tailwind CSS, Vite
- **Backend**: Node.js, Express, TypeScript, REST APIs, GraphQL
- **Databases**: PostgreSQL, MongoDB, Redis, SQLite
- **Testing**: Jest, Vitest, Cypress, Playwright

#### Mobile Development  
- **Android**: Kotlin, Java, Android Studio, Jetpack Compose
- **Cross-Platform**: Flutter, Dart, React Native
- **Backend**: Firebase, Supabase, Custom APIs
- **Testing**: Espresso, Flutter Test, Detox

#### Desktop Development
- **Electron**: JavaScript/TypeScript, React/Vue
- **Tauri**: Rust backend, Web frontend
- **Native**: Swift (macOS), C# (Windows)
- **Packaging**: electron-builder, tauri-bundler

#### Web Scraping & Automation
- **Tools**: Playwright, Puppeteer, Selenium
- **Languages**: TypeScript, Python, Node.js
- **Patterns**: Headless browsers, API scraping, Data extraction
- **Storage**: JSON, CSV, Databases

#### Common Tools Across All Domains
- **Version Control**: Git, GitHub
- **Package Managers**: npm, yarn, pnpm, pip, cargo, brew (macOS), chocolatey (Windows), apt (Linux)
- **Containerization**: Docker, Docker Compose
- **CI/CD**: GitHub Actions, GitLab CI
- **Code Quality**: ESLint, Prettier, Husky

### Platform-Specific Considerations

#### Windows Development
- **Shell**: PowerShell, Command Prompt, Git Bash, WSL2
- **Path Separator**: Backslash `\` (handle in code)
- **Line Endings**: CRLF (configure Git autocrlf)
- **Admin Rights**: May require elevation for some operations
- **Android Studio**: Native Windows installation preferred

#### macOS Development
- **Shell**: zsh (default), bash
- **Path Separator**: Forward slash `/`
- **Line Endings**: LF
- **Permissions**: May require sudo for system operations
- **Xcode**: Required for iOS development

#### Linux Development
- **Shell**: bash, zsh
- **Path Separator**: Forward slash `/`
- **Line Endings**: LF
- **Package Manager**: apt, yum, dnf, snap
- **WSL2 Integration**: Seamless Windows interop

### MCP Server Ecosystem
- **Development**: git, serena, ide
- **Documentation**: context7, readwise, sequential-thinking
- **Database**: supabase
- **Testing**: playwright, puppeteer
- **Monitoring**: sentry, gmail
- **Deployment**: vercel
- **Knowledge**: readwise, context7

## WORKFLOW PATTERNS

### Development Cycle by Project Type
```yaml
web_development:
  1_setup: "React/Next.js with TypeScript"
  2_development: "Component-driven with hot reload"
  3_testing: "Jest for units, Cypress/Playwright for E2E"
  4_deployment: "Vercel, Netlify, or self-hosted"
  
mobile_development:
  1_setup: "Android Studio or Flutter setup"
  2_development: "Emulator/device testing"
  3_testing: "Platform-specific test suites"
  4_deployment: "Play Store, App Store"
  
desktop_development:
  1_setup: "Electron/Tauri project structure"
  2_development: "Main/renderer process architecture"
  3_testing: "Cross-platform testing"
  4_packaging: "Platform-specific installers"
  
web_scraping:
  1_analysis: "Target site structure analysis"
  2_development: "Playwright/Puppeteer scripts"
  3_testing: "Rate limiting, error handling"
  4_deployment: "Scheduled jobs or APIs"
```

### Agent Orchestration
```yaml
task_routing:
  simple: "Direct agent → Single MCP tool"
  medium: "2-3 agents → Sequential workflow"
  complex: "studio-coach → Multi-agent orchestration"
  
quality_gates:
  pre_commit: "lint, typecheck, test"
  pre_deploy: "build, security scan, performance check"
  post_deploy: "monitoring, error tracking, analytics"
```

## ENVIRONMENT CONFIGURATION

### Local Development
```bash
# Required environment variables
NODE_ENV=development
DATABASE_URL=postgresql://...
SUPABASE_URL=https://...
SUPABASE_ANON_KEY=...
SENTRY_DSN=...
VERCEL_TOKEN=...
```

### MCP Server Requirements
```yaml
essential_servers:
  git: "Version control - ESSENTIAL for all projects"
  ide: "Code intelligence - Helpful for all development"
  playwright: "Web scraping, testing, automation"
  puppeteer: "Alternative browser automation"
  
optional_servers:
  serena: "Code analysis and refactoring"
  context7: "Documentation management"
  sequential-thinking: "Complex problem analysis"
```

## CROSS-PLATFORM COMPATIBILITY

### Path Handling
```javascript
// Always use path.join() or path.resolve() for cross-platform paths
const path = require('path');
const configPath = path.join(os.homedir(), '.config', 'app');

// Never hardcode path separators
// ❌ Wrong: 'src/components/Header.tsx'
// ✅ Right: path.join('src', 'components', 'Header.tsx')
```

### Environment Detection

#### Using Project Language
```javascript
// JavaScript/TypeScript (Node.js)
const platform = process.platform; // 'win32', 'darwin', 'linux'

// Python
import platform
os_type = platform.system() # 'Windows', 'Darwin', 'Linux'

// Java
String os = System.getProperty("os.name"); // "Windows 10", "Mac OS X", "Linux"

// Rust
let os = std::env::consts::OS; // "windows", "macos", "linux"

// Go
runtime.GOOS // "windows", "darwin", "linux"
```

#### Using Shell Commands
```bash
# Universal shell detection
uname -s  # Darwin (macOS), Linux, MINGW64_NT (Git Bash on Windows)

# Alternative checks
echo $OSTYPE  # darwin*, linux-gnu*, msys, cygwin
[[ "$OSTYPE" == "darwin"* ]] && echo "macOS"
[[ "$OSTYPE" == "linux-gnu"* ]] && echo "Linux"
[[ "$OSTYPE" == "msys" ]] && echo "Windows"
```

### Shell Commands
```yaml
cross_platform_commands:
  file_operations:
    windows: "copy, del, dir, type"
    unix: "cp, rm, ls, cat"
  
  npm_scripts:
    # Use cross-env for environment variables
    "build": "cross-env NODE_ENV=production webpack"
    # Use rimraf for cross-platform rm -rf
    "clean": "rimraf dist"
```

## CODING STANDARDS

### TypeScript Configuration
```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
```

### Code Quality Rules
- **Formatting**: Prettier with 2-space indentation
- **Linting**: ESLint with recommended rules
- **Imports**: Absolute imports from @/ alias
- **Components**: Functional components with TypeScript
- **State Management**: Context API or Zustand
- **API Calls**: Async/await with proper error handling
- **Testing**: Minimum 80% coverage for critical paths

### Naming Conventions
```yaml
files:
  components: "PascalCase.tsx"
  utilities: "camelCase.ts"
  constants: "UPPER_SNAKE_CASE.ts"
  types: "PascalCase.types.ts"
  tests: "*.test.ts or *.spec.ts"
  
variables:
  constants: "UPPER_SNAKE_CASE"
  functions: "camelCase"
  classes: "PascalCase"
  interfaces: "IPascalCase"
  types: "TPascalCase"
  enums: "EPascalCase"
```

## SECURITY PROTOCOLS

### Credential Management
- **Never commit**: API keys, passwords, tokens
- **Use env files**: .env.local for development
- **Validate inputs**: All user inputs sanitized
- **HTTPS only**: Enforce SSL in production
- **CORS configuration**: Whitelist allowed origins

### Data Protection
- **Encryption**: At rest and in transit
- **Authentication**: JWT with refresh tokens
- **Authorization**: Role-based access control
- **Rate limiting**: API endpoint protection
- **Audit logging**: Track sensitive operations

## PERFORMANCE TARGETS

### Frontend Metrics
- **First Contentful Paint**: < 1.5s
- **Time to Interactive**: < 3.5s
- **Cumulative Layout Shift**: < 0.1
- **Bundle Size**: < 200KB gzipped

### Backend Metrics
- **API Response Time**: < 200ms p95
- **Database Query Time**: < 50ms p95
- **Error Rate**: < 0.1%
- **Uptime**: > 99.9%

## MONITORING & OBSERVABILITY

### Error Tracking
```yaml
sentry_integration:
  environments: ["production", "staging"]
  capture_rate: 1.0
  trace_rate: 0.1
  profile_rate: 0.1
  alerts:
    - error_spike
    - performance_regression
    - crash_free_rate
```

### Analytics
```yaml
metrics_tracking:
  user_engagement: "Page views, session duration, bounce rate"
  feature_adoption: "Feature flags, A/B tests, conversion rates"
  performance: "Core Web Vitals, API latency, error rates"
  business: "User growth, retention, revenue metrics"
```

## DEPLOYMENT STRATEGY

### Environments
```yaml
development:
  url: "http://localhost:3000"
  database: "local PostgreSQL"
  features: "All flags enabled"
  
staging:
  url: "https://staging.project.vercel.app"
  database: "Supabase staging"
  features: "Production-like"
  
production:
  url: "https://project.vercel.app"
  database: "Supabase production"
  features: "Progressive rollout"
```

### Release Process
1. **Feature Branch**: Development and testing
2. **Pull Request**: Code review and CI checks
3. **Staging Deploy**: Automated via Vercel
4. **Production Deploy**: Manual approval required
5. **Monitoring**: Sentry alerts and analytics

## COMMUNICATION PROTOCOLS

### Commit Messages
```yaml
format: "<type>(<scope>): <subject>"
types:
  feat: "New feature"
  fix: "Bug fix"
  docs: "Documentation"
  style: "Formatting"
  refactor: "Code restructuring"
  perf: "Performance improvement"
  test: "Testing"
  chore: "Maintenance"
```

### Pull Request Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No new warnings
```

## CONTINUOUS IMPROVEMENT

### Metrics Dashboard
- **Development Velocity**: Story points per sprint
- **Code Quality**: Technical debt ratio
- **Test Coverage**: Line and branch coverage
- **Performance**: Lighthouse scores
- **User Satisfaction**: NPS and feedback scores

### Review Cycles
- **Weekly**: Sprint retrospectives
- **Monthly**: Performance reviews
- **Quarterly**: Architecture reviews
- **Annually**: Technology stack evaluation

## TROUBLESHOOTING GUIDE

### Common Issues
```yaml
build_failures:
  check: "Node version, dependencies, environment variables"
  fix: "Clear cache, reinstall dependencies"
  
test_failures:
  check: "Test environment, mock data, async handling"
  fix: "Update snapshots, fix timing issues"
  
deployment_issues:
  check: "Build logs, environment config, API keys"
  fix: "Verify secrets, check Vercel settings"
```

### Debug Commands
```bash
# Development debugging
npm run dev:debug
npm run test:debug
npm run build:analyze

# Production debugging
vercel logs
sentry releases
supabase db diff
```

## KNOWLEDGE BASE

### Documentation Links
- **Internal Docs**: /docs folder in repository
- **API Documentation**: OpenAPI/Swagger specs
- **Component Library**: Storybook documentation
- **Architecture Decisions**: ADR (Architecture Decision Records)

### External Resources
- **React Docs**: https://react.dev
- **TypeScript Handbook**: https://www.typescriptlang.org/docs
- **Supabase Docs**: https://supabase.com/docs
- **Vercel Docs**: https://vercel.com/docs
- **MCP Specification**: https://modelcontextprotocol.io

---

**Note**: This context file should be updated as the project evolves. All team members should be familiar with these guidelines and follow them consistently.