# Defense Demo Script (3-5 min)

## 0) Start
- Open: `http://localhost:8090`
- Login with one click: `Demo Login (1 click)`

## 1) Stability (40s)
- Open `Tasks`.
- Mark one task as completed.
- Click `Undo` in snackbar.
- Explain: critical actions are reversible, no accidental data loss.

## 2) UX/UI (60s)
- Show new overview card: `Total / Active / Done / Overdue` + progress bar.
- Open filters and set `Status = Active`, `Sort = Priority`.
- Explain: faster focus on important tasks and status control.

## 3) Functionality (80s)
- Open task menu (three dots) -> `Duplicate`.
- Create task in `Add Task` modal:
  - Type title.
  - Use due date quick presets: `Today`, `Tomorrow`, `+7 days`.
- Complete new task and show XP increment.

## 4) Reliability proof (40s)
- Mention that smoke tests passed locally:
  - Non-integration tests: passed
  - Integration smoke: passed

## 5) Final message (20s)
- "За последние часы фокус был на трех вещах: стабильность операций, скорость ежедневной работы через UX, и прикладные функции, которые реально экономят время команды."

## Backup answers (if asked)
- **What if user deletes task by mistake?** -> Undo snackbar + snapshot restore.
- **How fast can users add tasks now?** -> One modal + instant due-date presets.
- **How to focus on urgent work?** -> Status/category/priority filters + priority sorting + overdue visibility.
