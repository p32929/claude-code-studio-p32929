# AGENTS - Rapid Selection Guide & Intelligent Orchestrator

**Primary Directive**: "Agents First, Tools Second - Expert Context Over General Purpose"

## ⚡ RAPID AGENT SELECTION

### 🚨 MANDATORY UTILITY AGENTS (5)
**NEVER use direct tools for these domains**

| Agent | Domain | Trigger Keywords |
|-------|--------|------------------|
| **file-creator** | File/directory creation | "create", "generate", "new file", "setup structure" |
| **git-workflow** | All git operations | "commit", "branch", "merge", "git", "push", "pull" |
| **context-fetcher** | Internal documentation | "docs", "README", "internal guide", "project docs" |
| **knowledge-fetcher** | External research | "search", "Readwise", "Context7", "web search", "find articles" |
| **date-checker** | Date/time calculations | "when", "schedule", "time since", "date", "timestamp" |

### 🎯 INSTANT AGENT MATCHING

| User Intent | Primary Agent | Secondary Options |
|-------------|---------------|-------------------|
| **"Build new feature"** | rapid-prototyper | → ui-designer → frontend-developer |
| **"Fix this bug"** | backend-architect / frontend-developer | + test-writer-fixer (auto-triggers) |
| **"Test this code"** | test-writer-fixer | + api-tester, performance-benchmarker |
| **"Deploy this"** | devops-automator | + project-shipper |
| **"Design this UI"** | ui-designer | → frontend-developer → whimsy-injector |
| **"Analyze feedback"** | feedback-synthesizer | + ux-researcher |
| **"Complex multi-step"** | **studio-coach** | (orchestrates others) |

### 🔀 COMPLEXITY ROUTING

```yaml
Simple (1 agent):     Direct task → Specialized agent
Medium (2-3 agents):  Sequential workflow → Auto-handoffs  
Complex (4+ agents):  studio-coach → Orchestrated workflow
```

## 🎼 ORCHESTRATION WORKFLOWS

### 🏆 MASTER ORCHESTRATOR: studio-coach

**Auto-activates when:**
- 4+ agents needed
- Cross-domain complexity
- Multi-phase projects
- Agent coordination required

### 🎯 AUTO-TRIGGERING AGENTS

| Trigger Event | Agent | Purpose |
|---------------|-------|---------|
| Code changes | **test-writer-fixer** | Immediate test coverage |
| UI/UX changes | **whimsy-injector** | Add delightful interactions |
| Feature flags mentioned | **experiment-tracker** | A/B testing setup |
| Complex workflows start | **studio-coach** | Orchestration management |

## 🎯 SPECIALIZED AGENT DIRECTORY

### 🛠️ Engineering (7 agents)
- **rapid-prototyper**: MVP builder → ui-designer, test-writer-fixer
- **backend-architect**: API design → devops-automator, api-tester
- **frontend-developer**: UI implementation → ui-designer, whimsy-injector
- **mobile-app-builder**: Native apps → app-store-optimizer
- **ai-engineer**: AI/ML integration → performance-benchmarker
- **devops-automator**: Deployment → project-shipper, infrastructure-maintainer
- **test-writer-fixer**: Testing strategy → api-tester, test-results-analyzer

### 🎨 Design (5 agents)
- **ui-designer**: Interface design → frontend-developer, brand-guardian
- **ux-researcher**: User insights → feedback-synthesizer, analytics-reporter
- **whimsy-injector**: Interaction delight (auto-triggers after UI changes)
- **brand-guardian**: Visual consistency → visual-storyteller
- **visual-storyteller**: Marketing visuals → content-creator

### 📈 Marketing (7 agents)
- **growth-hacker**: Viral loops → analytics-reporter, experiment-tracker
- **tiktok-strategist**: TikTok content → content-creator
- **app-store-optimizer**: ASO → mobile-app-builder
- **content-creator**: Multi-platform content → instagram-curator, twitter-engager
- **instagram-curator**: Visual content → visual-storyteller
- **reddit-community-builder**: Community engagement → support-responder
- **twitter-engager**: Trend engagement → trend-researcher

### 🎯 Product (3 agents)
- **feedback-synthesizer**: User feedback → ux-researcher, sprint-prioritizer
- **sprint-prioritizer**: Planning → rapid-prototyper, studio-producer
- **trend-researcher**: Market analysis → growth-hacker

### 📋 Project Management (3 agents)
- **experiment-tracker**: A/B testing (auto-triggers on feature flags)
- **project-shipper**: Launch management → devops-automator
- **studio-producer**: Team coordination → studio-coach

### 🏢 Operations (5 agents)
- **analytics-reporter**: Data insights → experiment-tracker
- **finance-tracker**: Profitability → infrastructure-maintainer
- **infrastructure-maintainer**: Scaling → devops-automator
- **legal-compliance-checker**: Legal review → project-shipper
- **support-responder**: Customer support → feedback-synthesizer

### 🧪 Testing (5 agents)
- **api-tester**: API validation → backend-architect, performance-benchmarker
- **performance-benchmarker**: Speed optimization → test-results-analyzer
- **test-results-analyzer**: Failure patterns → test-writer-fixer
- **tool-evaluator**: Tech decisions → workflow-optimizer
- **workflow-optimizer**: Process improvement → studio-producer

### 🎭 Bonus Agents
- **joker**: Morale boost → whimsy-injector

## 🎯 AGENT SELECTION MATRIX

### Decision Tree
```yaml
task_analysis:
  utility_domain: USE_MANDATORY_AGENT (no alternatives)
  single_domain: USE_SPECIALIZED_AGENT
  cross_domain: SEQUENTIAL_WORKFLOW (2-3 agents)
  complex_project: STUDIO_COACH_ORCHESTRATION (4+ agents)
  
coordination_level:
  simple: Direct agent selection
  medium: Auto-handoffs between 2-3 agents
  complex: studio-coach orchestrated workflows
  
urgency:
  immediate: Single specialized agent
  planned: Sequential workflow
  strategic: Full orchestration with parallel teams
```

### Agent Relationship Map
```yaml
core_relationships:
  development_trio: [rapid-prototyper, frontend-developer, test-writer-fixer]
  design_duo: [ui-designer, whimsy-injector] 
  backend_stack: [backend-architect, devops-automator, api-tester]
  marketing_squad: [growth-hacker, content-creator, tiktok-strategist]
  testing_team: [test-writer-fixer, api-tester, performance-benchmarker, test-results-analyzer]
  
auto_triggers:
  code_change: test-writer-fixer
  ui_change: whimsy-injector  
  feature_flags: experiment-tracker
  complex_workflow: studio-coach
```

**Agent orchestration is as important as agent selection** - Use studio-coach for complex coordination, leverage auto-triggering for workflow continuity, and prefer agent teams over solo agent work for comprehensive solutions.

## 📚 DETAILED AGENT CAPABILITIES

### 🚨 Utility Agents (Mandatory Use)

#### file-creator
**Purpose**: Intelligent file and directory creation with templates
**Capabilities**:
- Create single or multiple files with proper structure
- Generate directory trees from specifications
- Apply language-specific templates and boilerplate
- Set up project scaffolding with best practices
- Handle file permissions and encoding
**MCP Integration**: None (uses native Write/MultiEdit tools)
**Example Triggers**: "create a new React component", "set up project structure", "generate API endpoints"

#### git-workflow
**Purpose**: Comprehensive git operations and version control
**Capabilities**:
- Smart commit message generation following conventions
- Branch management and merging strategies
- Conflict resolution assistance
- Pull request creation and management
- Git history analysis and cleanup
**MCP Integration**: git server for all operations
**Example Triggers**: "commit these changes", "create a feature branch", "prepare PR for review"

#### context-fetcher
**Purpose**: Internal documentation and codebase knowledge retrieval
**Capabilities**:
- Search and retrieve project documentation
- Find code examples and patterns
- Locate configuration files and settings
- Extract architectural decisions and rationale
- Compile relevant context for tasks
**MCP Integration**: context7 for documentation indexing
**Example Triggers**: "show me the API docs", "find examples of this pattern", "what's the project structure"

#### knowledge-fetcher
**Purpose**: External research and knowledge synthesis
**Capabilities**:
- Search technical documentation and tutorials
- Find best practices and industry standards
- Research library/framework solutions
- Compile comparative analyses
- Extract insights from multiple sources
**MCP Integration**: readwise, context7, WebSearch
**Example Triggers**: "research React performance optimization", "find best practices for API design"

#### date-checker
**Purpose**: Temporal calculations and scheduling
**Capabilities**:
- Calculate time differences and durations
- Parse and format dates across timezones
- Schedule task timelines
- Analyze temporal patterns in data
- Generate time-based reports
**MCP Integration**: None (uses native date tools)
**Example Triggers**: "when was this last updated", "calculate sprint duration", "schedule deployment window"

### 🛠️ Engineering Agents

#### rapid-prototyper
**Purpose**: Quick MVP and proof-of-concept development
**Capabilities**:
- Generate functional prototypes from requirements
- Create minimal viable implementations
- Set up development environments quickly
- Integrate essential features rapidly
- Balance speed with maintainability
**MCP Integration**: git, ide, serena
**Handoffs**: → ui-designer (for UI), → test-writer-fixer (for validation)
**Example Triggers**: "build a quick prototype", "create MVP for this feature", "proof of concept needed"

#### backend-architect
**Purpose**: API design and backend system architecture
**Capabilities**:
- Design RESTful and GraphQL APIs
- Implement authentication and authorization
- Optimize database schemas and queries
- Set up microservices architecture
- Handle scaling and performance concerns
**MCP Integration**: supabase, sentry, serena
**Handoffs**: → devops-automator (deployment), → api-tester (validation)
**Example Triggers**: "design the API structure", "optimize database queries", "implement auth system"

#### frontend-developer
**Purpose**: UI implementation and frontend architecture
**Capabilities**:
- Implement responsive UI components
- Manage state and data flow
- Optimize frontend performance
- Handle browser compatibility
- Integrate with backend APIs
**MCP Integration**: ide, serena, playwright
**Handoffs**: → ui-designer (design), → whimsy-injector (polish)
**Example Triggers**: "implement this UI design", "add frontend routing", "optimize React performance"

#### mobile-app-builder
**Purpose**: Native and cross-platform mobile development
**Capabilities**:
- Build iOS and Android applications
- Implement native device features
- Handle platform-specific requirements
- Optimize mobile performance
- Manage app store submissions
**MCP Integration**: ide, serena
**Handoffs**: → app-store-optimizer (ASO), → test-writer-fixer (testing)
**Example Triggers**: "create React Native app", "implement push notifications", "add offline support"

#### ai-engineer
**Purpose**: AI/ML integration and implementation
**Capabilities**:
- Integrate LLMs and AI services
- Implement machine learning models
- Design AI-powered features
- Optimize inference performance
- Handle data pipelines for ML
**MCP Integration**: serena, sequential-thinking
**Handoffs**: → performance-benchmarker (optimization), → test-writer-fixer (validation)
**Example Triggers**: "integrate OpenAI API", "implement recommendation system", "add AI chat feature"

#### devops-automator
**Purpose**: CI/CD and infrastructure automation
**Capabilities**:
- Set up deployment pipelines
- Configure cloud infrastructure
- Implement monitoring and alerting
- Automate operational tasks
- Manage environment configurations
**MCP Integration**: vercel, git, sentry
**Handoffs**: → project-shipper (release), → infrastructure-maintainer (scaling)
**Example Triggers**: "set up CI/CD pipeline", "configure auto-deployment", "add monitoring"

#### test-writer-fixer
**Purpose**: Comprehensive testing strategy and implementation
**Capabilities**:
- Write unit and integration tests
- Create E2E test scenarios
- Fix failing tests and flaky tests
- Improve test coverage
- Set up testing infrastructure
**MCP Integration**: playwright, puppeteer, ide
**Handoffs**: → api-tester (API validation), → test-results-analyzer (analysis)
**Auto-Triggers**: After code changes, before deployments
**Example Triggers**: "write tests for this feature", "fix failing tests", "improve coverage"

### 🎨 Design Agents

#### ui-designer
**Purpose**: Interface design and user experience
**Capabilities**:
- Create intuitive UI layouts
- Design component systems
- Implement design tokens
- Ensure accessibility standards
- Create responsive designs
**MCP Integration**: ide for component generation
**Handoffs**: → frontend-developer (implementation), → brand-guardian (consistency)
**Example Triggers**: "design the dashboard UI", "create component library", "improve UX flow"

#### ux-researcher
**Purpose**: User research and experience optimization
**Capabilities**:
- Analyze user behavior patterns
- Conduct usability assessments
- Create user personas and journeys
- Identify pain points and opportunities
- Generate UX improvement recommendations
**MCP Integration**: readwise for research
**Handoffs**: → feedback-synthesizer (insights), → analytics-reporter (metrics)
**Example Triggers**: "analyze user flow", "identify UX improvements", "create user journey map"

#### whimsy-injector
**Purpose**: Delightful interactions and micro-animations
**Capabilities**:
- Add smooth transitions and animations
- Create engaging micro-interactions
- Implement Easter eggs and surprises
- Polish UI with subtle effects
- Enhance user delight factors
**MCP Integration**: ide for code generation
**Auto-Triggers**: After UI implementation
**Example Triggers**: "add animations", "make it more delightful", "polish the interactions"

### 📊 Analytics & Testing Agents

#### api-tester
**Purpose**: API validation and contract testing
**Capabilities**:
- Test REST and GraphQL endpoints
- Validate response schemas
- Check authentication flows
- Test error handling
- Performance test APIs
**MCP Integration**: playwright, puppeteer
**Handoffs**: → backend-architect (fixes), → performance-benchmarker (optimization)
**Example Triggers**: "test all API endpoints", "validate API responses", "check auth flow"

#### performance-benchmarker
**Purpose**: Performance testing and optimization
**Capabilities**:
- Measure application performance
- Identify bottlenecks
- Run load and stress tests
- Optimize critical paths
- Generate performance reports
**MCP Integration**: playwright, sentry
**Handoffs**: → test-results-analyzer (analysis), → infrastructure-maintainer (scaling)
**Example Triggers**: "benchmark performance", "find bottlenecks", "optimize load time"

#### test-results-analyzer
**Purpose**: Test failure analysis and patterns
**Capabilities**:
- Analyze test failure patterns
- Identify flaky tests
- Generate test reports
- Recommend test improvements
- Track test metrics over time
**MCP Integration**: sentry for error tracking
**Handoffs**: → test-writer-fixer (improvements)
**Example Triggers**: "analyze test failures", "find flaky tests", "generate test report"

### 🚀 Deployment & Operations Agents

#### project-shipper
**Purpose**: Release management and deployment coordination
**Capabilities**:
- Coordinate release processes
- Manage deployment checklists
- Handle rollback procedures
- Communicate release notes
- Ensure deployment readiness
**MCP Integration**: vercel, git
**Handoffs**: → devops-automator (deployment), → infrastructure-maintainer (monitoring)
**Example Triggers**: "prepare for release", "deploy to production", "manage rollout"

#### infrastructure-maintainer
**Purpose**: Infrastructure scaling and maintenance
**Capabilities**:
- Monitor infrastructure health
- Scale resources based on load
- Optimize cloud costs
- Manage security updates
- Plan capacity requirements
**MCP Integration**: vercel, sentry
**Handoffs**: → devops-automator (automation), → finance-tracker (costs)
**Example Triggers**: "scale infrastructure", "optimize costs", "plan capacity"

### 🎭 Special Purpose Agents

#### studio-coach (Master Orchestrator)
**Purpose**: Complex project orchestration and coordination
**Capabilities**:
- Coordinate multiple agents for complex tasks
- Plan multi-phase project execution
- Manage agent handoffs and dependencies
- Optimize workflow efficiency
- Ensure comprehensive task completion
**MCP Integration**: All available servers
**Auto-Triggers**: When 4+ agents needed
**Example Triggers**: "build complete feature", "refactor entire module", "complex integration needed"

#### feedback-synthesizer
**Purpose**: User feedback analysis and insights
**Capabilities**:
- Aggregate feedback from multiple sources
- Identify common themes and patterns
- Prioritize improvement areas
- Generate actionable insights
- Track feedback trends over time
**MCP Integration**: readwise, gmail
**Handoffs**: → ux-researcher (deep analysis), → sprint-prioritizer (planning)
**Example Triggers**: "analyze user feedback", "synthesize reviews", "identify top complaints"

## 🔄 AGENT WORKFLOW PATTERNS

### Sequential Workflows
```yaml
feature_development:
  1: rapid-prototyper (initial implementation)
  2: ui-designer (interface design)
  3: frontend-developer (UI implementation)
  4: test-writer-fixer (test coverage)
  5: devops-automator (deployment setup)
  
api_development:
  1: backend-architect (API design)
  2: api-tester (validation)
  3: performance-benchmarker (optimization)
  4: devops-automator (deployment)
  
bug_fixing:
  1: test-results-analyzer (identify issue)
  2: backend/frontend-developer (fix implementation)
  3: test-writer-fixer (add regression tests)
  4: project-shipper (deploy fix)
```

### Parallel Workflows
```yaml
full_stack_feature:
  parallel_1:
    - backend-architect (API)
    - ui-designer (interface)
  parallel_2:
    - frontend-developer (UI)
    - api-tester (validation)
  parallel_3:
    - test-writer-fixer (tests)
    - performance-benchmarker (optimization)
  sequential:
    - devops-automator (deployment)
    - project-shipper (release)
```

### Conditional Workflows
```yaml
performance_optimization:
  if slow_api:
    - backend-architect
    - performance-benchmarker
  elif slow_ui:
    - frontend-developer
    - performance-benchmarker
  elif slow_queries:
    - backend-architect
    - infrastructure-maintainer
  always:
    - test-writer-fixer (validation)
    - project-shipper (deployment)
```

## 🎯 AGENT SELECTION BEST PRACTICES

### 1. Always Start with Utility Agents
- Check if task involves file creation → file-creator
- Check if task involves git → git-workflow
- Check if research needed → knowledge-fetcher or context-fetcher
- These are MANDATORY, never skip

### 2. Match Complexity to Orchestration
- Single task → Single specialized agent
- 2-3 related tasks → Sequential workflow
- 4+ tasks or cross-domain → studio-coach orchestration

### 3. Leverage Auto-Triggers
- Let test-writer-fixer auto-trigger after code changes
- Let whimsy-injector auto-trigger after UI work
- Let experiment-tracker auto-trigger for feature flags

### 4. Use Handoff Patterns
- Design → Implementation → Testing → Deployment
- Research → Planning → Execution → Validation
- Problem → Analysis → Solution → Verification

### 5. Prefer Teams Over Solo Agents
- Use development_trio for features
- Use backend_stack for APIs
- Use testing_team for quality assurance

## 🚦 AGENT PERFORMANCE METRICS

### Speed Rankings (Fastest to Slowest)
1. **Instant** (<1s): date-checker, file-creator
2. **Fast** (1-5s): git-workflow, context-fetcher, ui-designer
3. **Medium** (5-15s): frontend-developer, backend-architect, api-tester
4. **Slow** (15-30s): rapid-prototyper, test-writer-fixer, performance-benchmarker
5. **Variable** (5-60s): studio-coach, knowledge-fetcher, feedback-synthesizer

### Quality Rankings (Highest to Lowest Precision)
1. **Exact**: git-workflow, file-creator, date-checker
2. **Very High**: test-writer-fixer, api-tester, backend-architect
3. **High**: frontend-developer, ui-designer, devops-automator
4. **Good**: rapid-prototyper, performance-benchmarker, ux-researcher
5. **Variable**: knowledge-fetcher, feedback-synthesizer, whimsy-injector

### Token Efficiency (Most to Least Efficient)
1. **Minimal** (<500): date-checker, file-creator, git-workflow
2. **Low** (500-2000): api-tester, ui-designer, infrastructure-maintainer
3. **Medium** (2000-5000): frontend-developer, backend-architect, test-writer-fixer
4. **High** (5000-10000): rapid-prototyper, performance-benchmarker, devops-automator
5. **Very High** (10000+): studio-coach, knowledge-fetcher, feedback-synthesizer

## 🔍 TROUBLESHOOTING AGENT ISSUES

### Agent Not Responding
1. Check if agent exists in configuration
2. Verify trigger keywords match
3. Ensure MCP servers are running
4. Fall back to direct tools if needed

### Wrong Agent Selected
1. Review trigger keywords
2. Check complexity assessment
3. Consider manual agent specification
4. Use studio-coach for uncertainty

### Agent Handoff Failed
1. Verify both agents are available
2. Check handoff data compatibility
3. Use studio-coach for coordination
4. Manual intervention if needed

### Performance Issues
1. Check token usage per agent
2. Optimize parallel vs sequential
3. Use caching where possible
4. Consider simpler agent alternatives