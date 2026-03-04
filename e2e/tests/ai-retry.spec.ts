import { test, expect } from '@playwright/test';
import {
  clickByAnyText,
  loginWithCredentials,
  requireEnv,
  saveStepScreenshot,
} from './helpers';

test('S5-S6 mandatory: AI error state shows Retry when key is missing/invalid', async ({
  page,
}) => {
  const email = requireEnv('E2E_EMAIL');
  const password = requireEnv('E2E_PASSWORD');

  await loginWithCredentials(page, email, password);

  await clickByAnyText(page, ['AI помощник', 'AI Assistant']);
  await expect(page.getByText('AI Assistant')).toBeVisible({ timeout: 30_000 });

  const input = page.getByPlaceholder('Ask me anything...').first();
  await input.fill('Сделай план задач на неделю');
  await page.getByRole('button', { name: 'Send message' }).click();

  await expect(
    page.getByText(/AI сервис не настроен|Не удалось получить ответ AI/i),
  ).toBeVisible({ timeout: 30_000 });
  await expect(page.getByRole('button', { name: 'Retry' })).toBeVisible();
  await saveStepScreenshot(page, 's5-ai-error-retry.png');

  await page.getByRole('button', { name: 'Retry' }).click();
  await expect(
    page.getByText(/AI сервис не настроен|Не удалось получить ответ AI/i),
  ).toBeVisible({ timeout: 30_000 });
  await saveStepScreenshot(page, 's6-ai-retry-clicked.png');
});
