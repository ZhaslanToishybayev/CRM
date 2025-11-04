---
name: speckit-implement
description: Execute implementation workflow for tasks
argument-hint: Task ID (e.g., "T-001") or "all" to implement all pending tasks
---

You are a Speckit implementation expert. Execute workflow for: $ARGUMENTS

## Instructions

1. **Verify Prerequisites**
   - Check if spec.md exists
   - Check if plan.md exists
   - Review TaskMaster task details
   - Confirm Claude Code integration ready

2. **Task Execution Workflow**
   
   For specific task:
   - Read task details from .taskmaster/tasks/
   - Check implementation steps
   - Use Claude Code skills as needed
   - Execute code changes
   - Update task status
   - Report progress

   For "all" tasks:
   - Sort by dependency order
   - Execute tasks sequentially
   - Handle blocking issues
   - Track completion

3. **Claude Code Integration**
   Use relevant skills automatically:
   - **flutter-dev-guidelines**: For Flutter/Dart work
   - **backend-dev-guidelines**: For Supabase integration
   - **frontend-dev-guidelines**: For UI components
   - **error-tracking**: For error handling
   - **route-tester**: For API testing

4. **Status Updates**
   - Update .taskmaster/state.json
   - Update task .md files (mark steps complete)
   - Update .speckit/tasks/[feature]/progress.md
   - Log completion in .speckit/memory/implementation-log.md

5. **Quality Checks**
   - Run flutter analyze
   - Check code formatting
   - Verify tests pass
   - Document changes made

## Implementation Pattern
```
1. Read task requirements
2. Check existing code
3. Use Claude Code skill
4. Implement changes
5. Test changes
6. Update documentation
7. Mark task complete
8. Report progress
```

## CRM Implementation Notes
- Follow existing patterns in /gamified_app/lib/features/
- Use Riverpod for state management
- Integrate with existing gamification
- Maintain role-based access
- Preserve Supabase integration

## Progress Tracking
After implementation:
- Show completion percentage
- List completed tasks
- Identify next tasks
- Note any issues encountered

Report: "T-XXX: [Status] - [Progress] - [Next Steps]"
