---
name: speckit-analyze
description: Analyze spec/plan/task consistency and completeness
argument-hint: Feature name or "project" to analyze entire project
---

You are a Speckit analysis expert. Analyze consistency for: $ARGUMENTS

## Instructions

1. **Comprehensive Review**
   - Read spec.md (if exists)
   - Read plan.md (if exists)
   - Read task files (if exist)
   - Check TaskMaster state
   - Review existing code

2. **Consistency Checks**
   Validate:
   - [ ] Requirements match implementation plan
   - [ ] Plan matches task breakdown
   - [ ] Tasks match code structure
   - [ ] Dependencies are correct
   - [ ] Time estimates are realistic
   - [ ] Integration points covered

3. **Completeness Assessment**
   Check for:
   - [ ] All user stories covered
   - [ ] All acceptance criteria defined
   - [ ] Edge cases considered
   - [ ] Error handling planned
   - [ ] Testing strategy defined
   - [ ] Documentation planned

4. **Gap Analysis**
   Identify:
   - Missing specifications
   - Incomplete plans
   - Orphan tasks
   - Circular dependencies
   - Unrealistic estimates
   - Integration gaps

5. **Generate Report**
   Create: `.speckit/analysis/[feature]-analysis.md` with:
   - Consistency score (0-100)
   - Completeness score (0-100)
   - Issues found
   - Recommendations
   - Fix suggestions
   - Priority improvements

## Analysis Framework

### Consistency Score
- 100: Perfect alignment
- 80-99: Minor gaps
- 60-79: Some issues
- 40-59: Major gaps
- <40: Major misalignment

### Completeness Score
- 100: Fully specified
- 80-99: Minor omissions
- 60-79: Some gaps
- 40-59: Significant gaps
- <40: Incomplete

## CRM-Specific Checks
- Role-based access covered
- Gamification integration planned
- Supabase backend considered
- Performance requirements met
- Security aspects covered

## Output Format
```markdown
# Analysis Report: [Feature]

## Scores
- Consistency: XX%
- Completeness: XX%
- Overall: XX%

## Issues Found
1. [Issue] - [Impact] - [Fix]

## Recommendations
1. [Recommendation] - [Priority]

## Next Steps
- [Action 1]
- [Action 2]
```

Provide actionable next steps for improvement.
