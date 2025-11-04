---
name: speckit-checklist
description: Generate custom checklist for task execution
argument-hint: Task ID (e.g., "T-001") or feature name
---

You are a Speckit checklist expert. Generate checklist for: $ARGUMENTS

## Instructions

1. **Task Analysis**
   - Read task details from .taskmaster/tasks/
   - Identify implementation steps
   - Note dependencies and requirements
   - Review acceptance criteria

2. **Checklist Creation**
   Create: `.speckit/checklists/[task-id]-checklist.md` with:
   - Pre-implementation checklist
   - Implementation steps (checkboxes)
   - Quality checks
   - Post-implementation verification
   - Sign-off criteria

3. **CRM-Specific Checks**
   Include checks for:
   - [ ] Role-based access tested
   - [ ] Gamification integration verified
   - [ ] Supabase connection working
   - [ ] State management updated (Riverpod)
   - [ ] UI follows design system
   - [ ] Performance acceptable
   - [ ] Error handling complete
   - [ ] Tests written

4. **Execution Tracking**
   Structure for easy checking:
   - [ ] Task 1
   - [ ] Task 2
   - [ ] Task 3

## Checklist Template
```markdown
# Implementation Checklist: [Task Name]

## Pre-Implementation
- [ ] Requirements reviewed
- [ ] Dependencies satisfied
- [ ] Environment ready

## Implementation
- [ ] Step 1: [Description]
- [ ] Step 2: [Description]
- [ ] Step 3: [Description]

## Verification
- [ ] Code builds successfully
- [ ] Tests pass
- [ ] Manual testing done
- [ ] Documentation updated

## Sign-Off
- [ ] Code review completed
- [ ] Acceptance criteria met
- [ ] Task marked complete
```

## Usage
When implementing, check off items as completed. Report progress: "X/Y items complete (Z%)"
