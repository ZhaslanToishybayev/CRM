import { defineConfig } from '@playwright/test';

const baseURL = process.env.E2E_BASE_URL ?? 'http://127.0.0.1:18080';
const useManagedWebServer = process.env.E2E_MANAGED_SERVER !== 'false';

export default defineConfig({
  testDir: './tests',
  fullyParallel: false,
  workers: 1,
  timeout: 180_000,
  expect: {
    timeout: 30_000,
  },
  retries: process.env.CI ? 1 : 0,
  reporter: [
    ['list'],
    ['html', { open: 'never', outputFolder: 'playwright-report' }],
    ['junit', { outputFile: 'test-results/results.xml' }],
  ],
  outputDir: 'test-results/artifacts',
  use: {
    baseURL,
    headless: true,
    trace: 'retain-on-failure',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
  webServer: useManagedWebServer
    ? {
        command:
          'bash -lc "cd .. && scripts/ci/serve_web_e2e.sh"',
        url: baseURL,
        reuseExistingServer: false,
        timeout: 300_000,
        env: {
          ...process.env,
          DEMO_MODE: process.env.DEMO_MODE ?? 'false',
          RUN_VERBOSE: process.env.RUN_VERBOSE ?? 'false',
          WEB_PORT: process.env.WEB_PORT ?? '18080',
          WEB_HOSTNAME: process.env.WEB_HOSTNAME ?? '127.0.0.1',
        },
      }
    : undefined,
});
