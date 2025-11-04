# Speckit Project Management

## Overview
Speckit is integrated with TaskMaster and Claude Code to provide end-to-end project management for the CRM Flutter application.

## Available Commands

### Core Workflow
- `/speckit.specify` - Create comprehensive feature specifications
- `/speckit.plan` - Generate implementation plan from specs
- `/speckit.tasks` - Break down plan into actionable tasks
- `/speckit.implement` - Execute implementation workflow
- `/speckit.analyze` - Analyze consistency and completeness

### Support Commands
- `/speckit.clarify` - Identify underspecified areas
- `/speckit.checklist` - Generate custom checklists
- `/speckit.constitution` - Manage project constitution

## Workflow Pattern

```
1. SPECIFY:    Define what to build
   ↓
2. PLAN:       Design how to build it
   ↓
3. TASKS:      Break into actionable steps
   ↓
4. IMPLEMENT:  Execute tasks with Claude Code
   ↓
5. ANALYZE:    Validate completeness
```

## Integration Map

```
┌─────────────────────────────────────────────────────────┐
│                    Speckit Workflow                     │
│                                                           │
│  Specify → Plan → Tasks → Implement → Analyze            │
│                                                           │
│        ↓              ↓              ↓                    │
│   .speckit/      .speckit/      .speckit/               │
│     specs/         plans/         tasks/                 │
│                                                           │
│  ┌─────────────────────────────────────────────┐        │
│  │         Claude Code Skills                  │        │
│  │  (Auto-activated based on context)          │        │
│  └─────────────────────────────────────────────┘        │
│                                                           │
│  ┌─────────────────────────────────────────────┐        │
│  │         TaskMaster Tasks                    │        │
│  │  (.taskmaster/tasks/)                       │        │
│  └─────────────────────────────────────────────┘        │
└─────────────────────────────────────────────────────────┘
```

## Directory Structure

```
.speckit/
├── memory/
│   ├── constitution.md          # Project guiding principles
│   ├── decisions/               # Architecture decisions
│   └── implementation-log.md    # Implementation history
├── specs/                       # Feature specifications
│   └── [feature-name]/
│       ├── spec.md
│       └── implementation-plan.md
├── plans/                       # Implementation plans
│   └── [feature-name]/
│       └── plan.md
├── tasks/                       # Task breakdowns
│   └── [feature-name]/
│       └── tasks.md
├── checklists/                  # Implementation checklists
│   └── [task-id]-checklist.md
├── clarifications/              # Questions and gaps
│   └── [feature]-clarifications.md
└── analysis/                    # Analysis reports
    └── [feature]-analysis.md
```

## Integration with Other Tools

### TaskMaster
- Tasks automatically created/updated
- Status synchronized
- Progress tracked

### Claude Code
- Skills auto-activate based on context
- Commands use relevant skills
- Implementation automated

### Flutter App
- Code follows constitution
- Architecture enforced
- Quality maintained

## Usage Examples

### Add New Feature
```bash
# 1. Specify the feature
/speckit.specify notifications system

# 2. Review and refine
/speckit.clarify notifications

# 3. Create implementation plan
/speckit.plan notifications

# 4. Break into tasks
/speckit.tasks notifications

# 5. Implement
/speckit.implement T-004

# 6. Analyze completeness
/speckit.analyze notifications
```

### Check Project Health
```bash
/speckit.analyze project
```

### View Constitution
```bash
/speckit.constitution view
```

## Benefits

### For Developers
- Clear implementation path
- Consistent architecture
- Automated workflows
- Quality enforcement

### For Project
- Reduced technical debt
- Faster development
- Better code quality
- Easier onboarding

### For Stakeholders
- Clear progress tracking
- Predictable delivery
- Quality assurance
- Risk mitigation

## Best Practices

1. **Always specify before building** - Prevents scope creep
2. **Use /speckit.analyze regularly** - Catches issues early
3. **Update constitution when needed** - Keeps guiding principles current
4. **Link all decisions** - Connect spec → plan → tasks → code
5. **Review constitution before major changes** - Ensures consistency

## Success Metrics
- Specifications complete before coding
- All tasks have clear acceptance criteria
- 80%+ test coverage maintained
- Zero architectural violations
- Code review process followed

---

**Last Updated**: 2025-11-04
**Version**: 1.0.0
