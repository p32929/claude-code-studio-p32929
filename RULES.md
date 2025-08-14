# ⛔ BLOCKING RULES - Non-Negotiable Behavioral Enforcement

## RULE #0: ⛔ AUTOMATIC AGENT DELEGATION (UNIVERSAL ENFORCEMENT)

### 🤖 MANDATORY PRE-ACTION PROTOCOL
**BEFORE ANY RESPONSE - SCAN FOR AGENT APPLICABILITY:**

```
STEP 1: KEYWORD ANALYSIS
- Scan user request for agent trigger keywords
- Match request context to agent specializations
- Identify task complexity and domain requirements

STEP 2: AGENT SELECTION MATRIX
IF utility_domain_detected: USE_MANDATORY_UTILITY_AGENT
ELIF single_domain_task: USE_SPECIALIZED_AGENT  
ELIF cross_domain_task: USE_STUDIO_COACH_ORCHESTRATION
ELSE: PROCEED_WITH_DIRECT_TOOLS

STEP 3: AUTO-DELEGATION
- Spawn appropriate agent(s) with task context
- ONLY use direct tools if NO agent matches or agent fails
- Document agent selection reasoning if non-obvious
```

### 🎯 TRIGGER KEYWORD MATRIX
**Utility Agents (MANDATORY)**:
- file creation, directory, template → file-creator
- git, commit, branch, merge, push → git-workflow
- date, time, schedule, timestamp → date-checker
- docs, readme, documentation → context-fetcher  
- search, research, readwise, web → knowledge-fetcher

**Domain Specialists**:
- mobile, android, ios, app → mobile-app-builder
- web, react, frontend, ui → frontend-developer
- api, backend, server, database → backend-architect
- test, testing, bug, debug → test-writer-fixer
- design, interface, ux → ui-designer
- deploy, deployment, production → devops-automator

**Cross-Domain Coordination**:
- complex, multi-step, coordinate → studio-coach
- analyze, investigate, research → appropriate domain + sequential-thinking

### ⚡ ENFORCEMENT HIERARCHY
1. **RULE #0 SUPERSEDES ALL**: Automatic agent delegation takes precedence over direct tool usage
2. **NO MANUAL OVERRIDE**: Cannot bypass agent delegation without explicit agent failure
3. **CONTEXT PRESERVATION**: Every agent delegation preserves conversation context through fresh spawns
4. **QUALITY ASSURANCE**: Agent expertise delivers superior results over general-purpose tool usage

## RULE #1: ⛔ AGENT-FIRST ENFORCEMENT (COGNITIVE STOP)

### 🚫 FORBIDDEN WITHOUT AGENTS
**STOP IMMEDIATELY if attempting these operations directly:**

- **file-creator** MANDATORY for: File creation (Write tool), Directory creation, Template application, Batch file operations
- **git-workflow** MANDATORY for: All git commands (commit, push, branch, merge), Repository operations, Version control workflows
- **context-fetcher** MANDATORY for: Documentation retrieval (Read tool for docs), Internal knowledge base access, Technical reference lookup
- **knowledge-fetcher** MANDATORY for: External research (Readwise, Context7), Web search operations, Knowledge synthesis from multiple sources
- **date-checker** MANDATORY for: Date/time calculations, Scheduling queries, Timestamp analysis

### ⛔ ENFORCEMENT PROTOCOL
```
BEFORE ANY TOOL USE:
1. PAUSE - Does an agent exist for this domain?
2. CHECK - Is this a utility agent mandatory domain?
3. REDIRECT - Use agent instead of direct tool
4. ONLY PROCEED with direct tools if NO AGENT EXISTS or AGENT FAILS
```

## RULE #2: ⛔ FILE SAFETY ENFORCEMENT

**MANDATORY Read-Before-Write Protocol:**
- Read tool MUST precede Write/Edit operations
- Absolute paths ONLY - no relative paths permitted
- Never auto-commit without explicit user permission

**MANDATORY Commit Message Standards:**
- Never reference "Claude", "AI", "assistant", or similar terms
- Use active voice and technical descriptions
- Focus on what changed, not who/what made the change
- Examples:
  - ✅ "Add automatic agent delegation protocol"  
  - ✅ "Optimize configuration token consumption by 18%"
  - ✅ "Enhance skin tone filter selection logic"
  - ❌ "Claude added automatic agent delegation"
  - ❌ "AI optimized the configuration files"
  - ❌ "Assistant enhanced the skin tone filter"
- **Enforcement**: git-workflow agent MUST validate and rewrite non-compliant messages
- **Auto-correction**: Replace AI references with appropriate technical descriptions

## RULE #3: ⛔ CODEBASE CHANGE ENFORCEMENT

**MANDATORY Discovery-Before-Change Protocol:**
- Complete project-wide discovery before ANY changes
- Search ALL file types for ALL variations of target terms
- Document all references with context and impact assessment
- Execute changes in coordinated manner following plan

# ✅ OPERATIONAL GUIDELINES - Best Practices & Standards

## Task Execution Standards

### Validation Protocols
- Always validate before execution, verify after completion
- Run lint/typecheck before marking tasks complete
- Maintain ≥90% context retention across operations
- Use batch tool calls when possible, sequential only when dependencies exist

### Framework Compliance
- Check package.json/requirements.txt before using libraries
- Follow existing project patterns and conventions
- Use project's existing import styles and organization
- Respect framework lifecycles and best practices

## Quality Assurance Pipeline

### Validation Sequence
1. **Syntax Check**: Language parsers and intelligent suggestions
2. **Type Validation**: Type compatibility and context-aware suggestions
3. **Code Quality**: Linting rules and refactoring suggestions
4. **Security Review**: Vulnerability assessment and compliance
5. **Testing**: Coverage analysis and validation
6. **Performance**: Benchmarking and optimization suggestions
7. **Documentation**: Completeness validation and accuracy verification
8. **Integration**: Deployment validation and compatibility verification

### Evidence Requirements
- **Quantitative**: Performance/quality/security metrics, coverage percentages
- **Qualitative**: Code quality improvements, security enhancements, UX improvements
- **Documentation**: Change rationale, test results, performance benchmarks

## Operational Safety Protocols

### ✅ ALWAYS Execute
- Agent-first approach for ALL operations
- Specialized agents for domain-specific tasks
- Batch operations for efficiency
- Complete discovery before codebase changes
- Verify completion with evidence

### ⛔ NEVER Execute
- Direct tools when agents are available (violates agent-first mandate)
- File modifications without Read operations
- Relative paths in file operations
- Framework pattern violations
- Changes without discovery phase
- Task completion without verification

---

# 🔒 ADVANCED ENFORCEMENT PATTERNS

## RULE #4: ⛔ CONTEXT PRESERVATION MANDATE

### Context Degradation Prevention
```yaml
context_monitoring:
  message_count: "Track conversation length"
  repetition_detection: "Flag repeated explanations"
  token_usage: "Monitor cumulative token consumption"
  quality_metrics: "Measure response relevance"
  
preservation_tactics:
  agent_delegation: "Offload to fresh context"
  summary_generation: "Compress old context"
  reference_indexing: "Link to previous decisions"
  state_persistence: "Save critical information"
```

### Context Overflow Protocol
**When approaching context limits:**
1. **Early Warning** (70% capacity): Start using more agents
2. **Critical Threshold** (85% capacity): Mandatory agent delegation
3. **Emergency Mode** (95% capacity): Studio-coach orchestration only
4. **Context Reset**: Never needed with proper agent usage

## RULE #5: ⛔ MCP SERVER COORDINATION

### Server Selection Hierarchy
```yaml
priority_order:
  1_native_tools: "Use when no MCP server available"
  2_mcp_servers: "Prefer when available and configured"
  3_agent_delegation: "Use when complexity warrants"
  4_fallback_chain: "Native → MCP → Agent → Manual"
```

### Server Failure Handling
**MANDATORY fallback sequence:**
1. **Detect Failure**: Server timeout or error
2. **Log Issue**: Document server and error type  
3. **Attempt Fallback**: Use alternative approach
4. **Notify User**: Only if no fallback available
5. **Continue Task**: Never block on single server

## RULE #6: ⛔ PARALLEL EXECUTION MANDATE

### Parallelization Requirements
**MUST parallelize when:**
- Multiple independent file reads
- Multiple search operations
- Multiple API calls
- Multiple test executions
- Multiple build commands

### Parallel Execution Patterns
```yaml
file_operations:
  parallel: [Read, Glob, Grep, LS]
  sequential: [Write, Edit, MultiEdit]
  
analysis_operations:
  parallel: [search, analyze, benchmark]
  sequential: [modify, validate, deploy]
  
agent_operations:
  parallel: [independent domains]
  sequential: [dependent workflows]
```

## RULE #7: ⛔ ERROR RECOVERY PROTOCOL

### Error Classification
```yaml
error_types:
  recoverable:
    - network_timeout
    - rate_limit
    - temporary_failure
    - permission_denied
  non_recoverable:
    - invalid_syntax
    - missing_dependency
    - corrupt_data
    - incompatible_version
```

### Recovery Strategies
**Automatic recovery for:**
1. **Retry with Backoff**: Network and timeout errors
2. **Alternative Tool**: When primary tool fails
3. **Agent Escalation**: When direct approach fails
4. **Graceful Degradation**: Partial functionality

### Error Documentation
**MANDATORY for all errors:**
- Error type and message
- Context when error occurred
- Recovery action taken
- Impact on task completion
- Preventive measures for future

## RULE #8: ⛔ SECURITY ENFORCEMENT

### Credential Protection
```yaml
never_expose:
  - api_keys
  - passwords  
  - tokens
  - secrets
  - private_keys
  
always_mask:
  - partial_display: "sk-...abc123"
  - environment_vars: "Use $ENV_VAR syntax"
  - config_files: "Reference, don't embed"
```

### Code Security Review
**MANDATORY checks before code generation:**
1. **Input Validation**: All user inputs sanitized
2. **SQL Injection**: Parameterized queries only
3. **XSS Prevention**: Output encoding
4. **CSRF Protection**: Token validation
5. **Authentication**: Proper auth checks
6. **Authorization**: Role-based access

## RULE #9: ⛔ PERFORMANCE OPTIMIZATION

### Token Usage Optimization
```yaml
token_limits:
  simple_task: "<1000 tokens"
  medium_task: "<5000 tokens"
  complex_task: "<15000 tokens"
  
optimization_tactics:
  - "Use agents for token-heavy operations"
  - "Batch similar operations"
  - "Cache repeated lookups"
  - "Summarize verbose content"
```

### Response Time Targets
**Maximum response times:**
- Simple query: <2 seconds
- File operation: <5 seconds  
- Search operation: <10 seconds
- Complex analysis: <30 seconds
- Full feature: <60 seconds

## RULE #10: ⛔ QUALITY GATES

### Pre-Execution Gates
```yaml
before_code_changes:
  - "Understand existing patterns"
  - "Check dependencies"
  - "Validate approach"
  - "Plan test strategy"
  
before_deployment:
  - "All tests passing"
  - "Lint checks clean"
  - "Type checks pass"
  - "Security scan clear"
```

### Post-Execution Validation
**MANDATORY after changes:**
1. **Syntax Validation**: Code parses correctly
2. **Type Checking**: No type errors
3. **Test Execution**: All tests pass
4. **Integration Check**: Works with system
5. **Performance Check**: Meets targets

## RULE #11: ⛔ DOCUMENTATION REQUIREMENTS

### Auto-Documentation Triggers
```yaml
document_when:
  - "New feature added"
  - "API endpoint created"
  - "Breaking change made"
  - "Complex logic implemented"
  - "Configuration changed"
```

### Documentation Standards
**MANDATORY elements:**
- Purpose and context
- Usage examples
- Input/output specifications
- Error conditions
- Performance characteristics
- Security considerations

## RULE #12: ⛔ TESTING MANDATE

### Test Coverage Requirements
```yaml
coverage_targets:
  critical_paths: "100%"
  business_logic: "90%"
  utilities: "80%"
  ui_components: "70%"
  
test_types:
  unit: "Every function/method"
  integration: "Every API endpoint"
  e2e: "Critical user flows"
  performance: "Heavy operations"
```

### Test-First Approach
**When MANDATORY:**
- Bug fixes (regression test first)
- New features (TDD approach)
- API changes (contract test first)
- Performance improvements (benchmark first)

## ENFORCEMENT ESCALATION

### Violation Response Matrix
```yaml
violation_severity:
  low:
    action: "Log warning"
    correction: "Suggest alternative"
    
  medium:
    action: "Block execution"
    correction: "Require confirmation"
    
  high:
    action: "Abort operation"
    correction: "Escalate to studio-coach"
    
  critical:
    action: "Full stop"
    correction: "Require user intervention"
```

### Compliance Monitoring
**Continuous checks for:**
- Agent usage rate (target: >80%)
- Parallel execution rate (target: >60%)
- Error recovery success (target: >95%)
- Context preservation (target: 100%)
- Security compliance (target: 100%)

## RULE PRIORITY CONFLICTS

### Conflict Resolution Order
1. **Security** always wins
2. **Context Preservation** second
3. **Agent-First** third
4. **Performance** fourth
5. **Documentation** fifth

### Override Conditions
**Only user can override with:**
- Explicit "skip agent" instruction
- Explicit "ignore security" instruction
- Explicit "skip tests" instruction
- Emergency "force proceed" command

---

# 📦 RULE PACKAGES

## Quick Start Package
**Essential rules for immediate productivity:**
- RULE #0: Automatic Agent Delegation
- RULE #1: Agent-First Enforcement  
- RULE #2: File Safety
- RULE #6: Parallel Execution

## Security Package  
**Critical for production systems:**
- RULE #2: File Safety
- RULE #8: Security Enforcement
- RULE #10: Quality Gates
- RULE #12: Testing Mandate

## Performance Package
**Optimal for large-scale projects:**
- RULE #4: Context Preservation
- RULE #6: Parallel Execution
- RULE #9: Performance Optimization
- RULE #5: MCP Server Coordination

## Enterprise Package
**Complete enforcement suite:**
- ALL RULES (0-12)
- Strict compliance monitoring
- Audit trail generation
- Automated reporting

---

**REMEMBER**: Rules exist to ensure consistent, high-quality, secure, and efficient development. When in doubt, delegate to an agent - they inherently follow all rules.