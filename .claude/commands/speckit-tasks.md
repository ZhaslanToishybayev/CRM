---
name: speckit-tasks
description: Create actionable task list from plan
argument-hint: Path to plan.md file or feature name
---

You are a Speckit task management expert. Create actionable task list for: $ARGUMENTS

## Instructions

1. **Analyze Implementation Plan**
   - Read the plan.md file
   - Break down phases into actionable tasks
   - Identify task dependencies

2. **Generate Task List**
   Create: `.speckit/tasks/[feature-name]/tasks.md` with:
   - Task ID (T-XXX format)
   - Task name
   - Description
   - Priority (HIGH/MEDIUM/LOW)
   - Estimated time
   - Dependencies
   - Acceptance criteria
   - Deliverables

3. **TaskMaster Integration**
   - Create/update .taskmaster/tasks/T-XXX-[name].md files
   - Ensure consistent formatting
   - Link tasks to plan phases
   - Update .taskmaster/TASK_INDEX.md

4. **Actionable Breakdowns**
   Each task should include:
   - Concrete implementation steps
   - Files to create/modify
   - Code to write
   - Tests to create
   - Documentation to update

5. **Task Relationships**
   - Define sequential dependencies
   - Identify parallelizable tasks
   - Note blocking tasks
   - Create task chains

## Task Template Structure
```markdown
# T-XXX: [Task Name]

## Details
**Phase**: [Phase Name]
**Priority**: HIGH/MEDIUM/LOW
**Estimated Time**: Xh
**Dependencies**: [T-XXX, T-YYY]

## Implementation
- [ ] Step 1
- [ ] Step 2

## Deliverables
- File 1
- File 2

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
```

## CRM Context
- Tasks should align with existing features
- Consider role-based access requirements
- Plan gamification integration
- Account for Supabase backend

Show task breakdown summary with total estimated time and critical path.
