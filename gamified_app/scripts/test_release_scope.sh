#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

flutter test --coverage \
  test/core/ \
  test/providers/auth_provider_test.dart \
  test/integration/auth_flow_test.dart \
  test/integration/supabase_integration_test.dart \
  test/security/auth_security_test.dart \
  test/security/data_protection_test.dart \
  test/features/notifications/notification_service_test.dart \
  test/widget_test.dart
