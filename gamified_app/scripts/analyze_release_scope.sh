#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

flutter analyze \
  lib/core/database/supabase_config.dart \
  lib/core/supabase/supabase_config.dart \
  lib/core/supabase/supabase_service.dart \
  lib/features/auth \
  lib/features/tasks/data_sources/supabase_task_data_source.dart \
  lib/features/notifications/services \
  lib/main.dart \
  lib/main_final.dart \
  test/core \
  test/providers/auth_provider_test.dart \
  test/integration/auth_flow_test.dart \
  test/integration/supabase_integration_test.dart \
  test/security/auth_security_test.dart \
  test/security/data_protection_test.dart \
  test/features/notifications/notification_service_test.dart \
  test/widget_test.dart \
  --no-fatal-infos \
  --no-fatal-warnings
