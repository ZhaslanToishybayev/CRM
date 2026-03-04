# Entrypoint And Router Policy

Single source of truth for web app startup:

- Entrypoint: `lib/main.dart`
- Router: `appRouterProvider` in `lib/main.dart`

Routes:

- `/login` -> `LoginScreen`
- `/app` -> `RootLayout`

Guard:

- Unauthenticated users are redirected to `/login`
- Authenticated users are redirected from `/login` to `/app`

Legacy duplicate entrypoints and routers were removed to avoid architectural drift.
