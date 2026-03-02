# Schema Mapping Matrix

## Tasks Mapping
| App Field | Legacy (`tasks`) | Corporate (`work_tasks`) |
|---|---|---|
| user id | `user_id` | `assignee_id` |
| reporter | `user_id` | `reporter_id` |
| title | `title` | `title` |
| description | `description` | `description` |
| priority | `low|medium|high` | `low|medium|high|urgent|critical` (mapped to app enum) |
| completion flag | `is_completed` | `is_completed` or `status=completed` |
| completed timestamp | `updated_at` (derived) | `completed_at` |

## User Stats/Profile Mapping
| App Field | Legacy (`user_stats`) | Corporate (`corporate_users`/`profiles`) |
|---|---|---|
| user id | `id` | `user_id` or `id` |
| username | `username` | `username` / `full_name` fallback |
| email | `email` | `email` |
| xp | `xp` | `total_xp` |
| level | `level` | `current_level` |
| streak | `streak` | `streak_count` |
| last task date | `last_task_date` | `last_task_date` |

## Drift Controls
- CI drift check compares row counts when both schemas exist.
- Manual SQL inspection available in `scripts/schema_drift_queries.sql`.
