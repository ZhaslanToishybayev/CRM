---
name: speckit-specify
description: Create comprehensive feature specifications for CRM project
argument-hint: Describe the feature to specify (e.g., "notifications system", "reporting dashboard")
---

You are a Speckit specifications expert. Create a comprehensive specification for: $ARGUMENTS

## Instructions

1. **Analyze CRM Context**
   - Review existing features in /gamified_app/lib/features/
   - Check TaskMaster tasks in .taskmaster/tasks/
   - Understand Flutter/Dart/Riverpod architecture

2. **Create Structured Specification**
   Create: `.speckit/specs/[feature-name]/spec.md` with:
   - Executive Summary
   - Functional Requirements
   - Technical Requirements
   - User Stories
   - Acceptance Criteria
   - Dependencies
   - Integration Points
   - Success Metrics

3. **Define Implementation Plan**
   Create: `.speckit/specs/[feature-name]/implementation-plan.md` with:
   - Architecture decisions
   - Code structure
   - Database schema (if needed)
   - API endpoints (if needed)
   - Component hierarchy
   - State management approach

4. **Link to TaskMaster**
   - Identify affected TaskMaster tasks
   - Update task dependencies
   - Create task breakdown if needed

5. **Integration Notes**
   - Document Supabase integration needs
   - Note Riverpod provider requirements
   - Specify UI/UX components needed

## Quality Standards
- Specifications must be complete and actionable
- Include technical diagrams where helpful
- Link to existing code examples
- Consider gamification aspects
- Account for role-based access

## CRM-Specific Considerations
- 4 role levels (Employee, Manager, Admin, SuperAdmin)
- Gamification system with XP and achievements
- Team hierarchy (Org → Dept → Team)
- Supabase backend with real-time features

Use existing Flutter patterns from /gamified_app/lib/features/ as reference.

After creation, provide summary of what was specified and link to TaskMaster tasks.
