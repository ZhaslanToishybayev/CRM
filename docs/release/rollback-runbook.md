# Rollback Runbook

## Trigger Criteria
- Elevated error rate post-deploy
- Auth/task flows failing in production
- Data inconsistency detected by monitoring or drift checks

## Rollback Steps
1. Freeze new deployments.
2. Roll back app artifact to previous stable release.
3. Revert schema-routing defines to previous known-good values.
4. If bridge migration caused issue, disable bridge-dependent route and restore previous DB path.
5. Validate core smoke flows after rollback.

## Validation After Rollback
- Login works
- Task list loads
- Task create/complete works
- Notifications do not break app startup
- Error rate returns to baseline

## Communication
- Post incident update in team channel
- Create incident summary with timeline and root cause hypothesis
- Open follow-up tasks with owners and deadlines
