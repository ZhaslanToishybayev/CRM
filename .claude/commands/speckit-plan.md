---
name: speckit-plan
description: Generate implementation plan from specifications
argument-hint: Path to spec.md file or feature name (e.g., "reports" or "specs/notifications/spec.md")
---

You are a Speckit planning expert. Generate implementation plan for: $ARGUMENTS

## Instructions

1. **Read Specification**
   - Locate and read the spec.md file
   - Analyze requirements and constraints
   - Review existing codebase structure

2. **Create Detailed Plan**
   Create: `.speckit/plans/[feature-name]/plan.md` with:
   - Phase breakdown (sprint-sized chunks)
   - Technical implementation steps
   - Code changes required (files to create/modify)
   - Database migrations (if needed)
   - API endpoint definitions
   - UI component specifications

3. **Update TaskMaster**
   - Create or update tasks in .taskmaster/tasks/
   - Set realistic time estimates
   - Define dependencies between tasks
   - Assign priority levels

4. **Integration Planning**
   - Plan Supabase integration points
   - Specify Riverpod provider updates
   - Define navigation changes
   - Plan testing strategy

5. **Risk Assessment**
   - Identify potential blockers
   - Plan mitigation strategies
   - Define success criteria

## Flutter-Specific Planning
- Follow Clean Architecture patterns
- Use feature-based structure
- Plan Provider/Riverpod state changes
- Consider Freezed models updates
- Plan UI component reuse

## Output Format
For each phase:
- **Phase N: [Name]**
  - Tasks (actionable items)
  - Deliverables
  - Time estimate
  - Dependencies
  - Acceptance criteria

Link to TaskMaster tasks created/updated.

After planning, show phase breakdown and total timeline estimate.
