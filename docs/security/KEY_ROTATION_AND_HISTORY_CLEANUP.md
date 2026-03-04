# Key Rotation And Git History Cleanup

## 1) Immediate rotation checklist

Rotate all potentially exposed credentials now:

1. Supabase:
- Go to `Project Settings -> API`.
- Regenerate `anon` key (and `service_role` if it was ever exposed).
- Update all runtime environments with new keys.

2. Z.AI / GLM:
- Revoke old `ZAI_API_KEY` in provider dashboard.
- Create a new key with least privilege.

3. Minimax:
- Revoke old `MINIMAX_API_KEY`.
- Create a new key and scope it to required models only.

4. SMTP:
- Revoke app password / token.
- Create a new app password.

## 2) Stop committing secrets

Repository rules:
- Keep only `.env.example` in git.
- Keep real `.env` / `.env.*` local only.
- Run app with `--dart-define` for web and CI/CD.

## 3) Remove secrets from git history

Use one method below.

### Option A: `git filter-repo` (recommended)

```bash
pip install git-filter-repo
git filter-repo --path .env.production --path .env.staging --invert-paths
git filter-repo --replace-text <(cat <<'EOF'
PASTE_OLD_SUPABASE_TOKEN_HERE==>REMOVED_SUPABASE_TOKEN
PASTE_OLD_ZAI_TOKEN_HERE==>REMOVED_ZAI_TOKEN
EOF
)
git push --force --all
git push --force --tags
```

### Option B: BFG Repo-Cleaner

```bash
java -jar bfg.jar --delete-files ".env.production,.env.staging"
java -jar bfg.jar --replace-text passwords.txt
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force --all
git push --force --tags
```

`passwords.txt` format:

```txt
PASTE_OLD_SUPABASE_TOKEN_HERE==>REMOVED_SUPABASE_TOKEN
PASTE_OLD_ZAI_TOKEN_HERE==>REMOVED_ZAI_TOKEN
```

## 4) Post-cleanup verification

Run secret scan before merge:

```bash
rg -n --hidden -P "(eyJ[A-Za-z0-9_-]{20,}\\.[A-Za-z0-9_-]{20,}\\.[A-Za-z0-9_-]{20,}|[A-Za-z0-9]{32}\\.[A-Za-z0-9]{16,}|sk-[A-Za-z0-9]{20,})" . -g '!build/**' -g '!.dart_tool/**' -g '!.git/**'
```

Expected result: no matches.
