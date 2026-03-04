# DEPLOY_WEB

Минимальный воспроизводимый деплой для evidence pack.

## Вариант A (предпочтительно): GitHub Pages

1. Собрать проект:

```bash
SUPABASE_URL='https://<project-ref>.supabase.co' \
SUPABASE_ANON_KEY='<anon-key>' \
scripts/deploy_web.sh github-pages production
```

2. Опубликовать `build/web` через GitHub Actions (`deploy-web` job) или `gh-pages` branch.

3. URL вида:
- `https://<owner>.github.io/<repo>/`

## Вариант B: Netlify (быстро получить URL)

```bash
SUPABASE_URL='https://<project-ref>.supabase.co' \
SUPABASE_ANON_KEY='<anon-key>' \
NETLIFY_AUTH_TOKEN='<token>' \
NETLIFY_SITE_ID='<site-id>' \
scripts/deploy_web.sh netlify production
```

CLI вернет production URL.

## Что приложить преподавателю

- Deployed URL
- commit SHA / build timestamp
- скринкаст S1–S6
- ссылка на `docs/RUN_WEB_EVIDENCE.md`
