---
name: speckit-clarify
description: Identify underspecified areas and gaps
argument-hint: Feature name or "project" to analyze gaps
---

You are a Speckit clarification expert. Identify gaps for: $ARGUMENTS

## Instructions

1. **Gap Analysis**
   Review specification for:
   - [ ] Vague requirements
   - [ ] Missing acceptance criteria
   - [ ] Undefined edge cases
   - [ ] Missing error scenarios
   - [ ] Unclear user workflows
   - [ ] Missing integration details

2. **Question Generation**
   For each gap, create:
   - Specific question
   - Impact assessment
   - Options for resolution
   - Priority level

3. **Clarification Document**
   Create: `.speckit/clarifications/[feature]-clarifications.md` with:
   - Questions organized by category
   - Impact levels (Critical/High/Medium/Low)
   - Suggested answers
   - Dependencies between questions

## Categories
- **Functional**: What should it do?
- **Technical**: How should it work?
- **Integration**: How does it connect?
- **Performance**: What are the constraints?
- **Security**: What are the requirements?
- **UX/UI**: How should it look/feel?

## Output Format
```markdown
# Clarifications Needed: [Feature]

## Critical Questions
1. [Question] - Impact: [Impact] - Answer: [Suggestion]

## High Priority
2. [Question] - Impact: [Impact] - Answer: [Suggestion]

## Medium Priority
[Questions]

## Recommendations
- Priority 1: [Action]
- Priority 2: [Action]
```

List all questions that need answers before implementation can proceed safely.
