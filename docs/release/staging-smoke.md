# Staging Smoke Test

## Pre-checks
- Correct staging env vars are set
- Database migrations/bridge applied as planned
- Build artifact corresponds to release candidate

## Smoke Scenarios
1. Auth
- Sign in with valid user
- Invalid credentials show expected error

2. Tasks
- Open task list
- Create task
- Complete task
- Refresh and verify state persistence

3. Reporting
- Open manager/employee report screens
- Verify charts/widgets render without crash

4. Notifications
- App bootstrap does not fail on notification init
- Local notification path can be invoked without exception

5. Schema Compatibility
- Run app with legacy defines
- Run app with corporate defines
- Validate core flows in both modes

## Exit Criteria
- No blocker severity defects
- No crash during core flow
- No schema mismatch indicators
