# Fast Stability Design (Week 1)

## Goal

Deliver a reliable web demo contour quickly by prioritizing compile safety,
smoke coverage, and deterministic CI over full test-suite correctness.

## Decisions

- Prioritize fast demo stability over full architecture cleanup.
- Keep integration tests non-blocking in week 1.
- Use `sql` as default demo backend mode.
- Gate CI on curated smoke tests while legacy test infrastructure is repaired.

## Implementation Strategy

1. Fix blocking test failures in core smoke paths (`widget`, `provider`, `model`).
2. Restore missing generated artifacts (`freezed/json/riverpod`).
3. Split CI into:
   - blocking: compile-safe analyze scope + non-integration smoke tests
   - non-blocking: integration smoke (legacy driver tests skipped)
4. Add reusable scripts for local/CI consistency.
5. Add report documenting baseline and residual risks.

## Acceptance Criteria

- Web demo can be launched reliably via script.
- Blocking CI checks pass on stable smoke suite.
- Integration smoke runs separately and does not block merge.
- Remaining legacy failures are documented for wave 2 migration.
