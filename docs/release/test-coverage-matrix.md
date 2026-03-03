# Test Coverage Matrix

## Mandatory Release Gates
| Layer | Scope | Command / Job | Block Release |
|---|---|---|---|
| Hygiene | Secrets, placeholders, TODO/HACK in critical paths | `scripts/check_repo_hygiene.sh` | Yes |
| Analyze (release scope) | Core auth/tasks/notifications/supabase paths | `scripts/analyze_release_scope.sh` | Yes |
| Tests (release scope) | Core unit/integration/security/widget smoke | `scripts/test_release_scope.sh` | Yes |
| Build | Web release build | `flutter build web --release` | Yes |
| Schema Drift | Legacy/corporate table count drift | `scripts/check_schema_drift.sh` | Yes (when `STAGING_DATABASE_URL` configured) |

## Extended Diagnostic Gates
| Layer | Scope | Command / Job | Block Release |
|---|---|---|---|
| Full Audit | Extended widgets/services/models suites | `scripts/test_full_audit.sh` | No (triage required) |
| Staging E2E | Web smoke on real staging | `staging_e2e` (Playwright) | No (mobile release); Yes for web go/no-go |

## Core Business Scenarios
| Scenario | Unit | Integration | Widget | E2E Staging |
|---|---|---|---|---|
| Auth sign in/sign out/reset | Yes | Yes | Yes | Yes |
| Task create/update/complete/delete | Yes | Yes | Yes | Yes |
| Notifications bootstrap | Yes | Yes | Optional | Yes |
| Schema routing compatibility | Yes | Yes | N/A | Yes |
| Reports rendering | Partial | Partial | Partial | Smoke |

## Known Gaps (Current)
- Extended legacy modules outside release scope are not stable enough for hard-gate release blocking.
- Full audit failures must be triaged into backlog with owner and ETA.
