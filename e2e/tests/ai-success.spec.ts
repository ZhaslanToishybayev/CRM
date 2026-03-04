import { test, expect } from '@playwright/test';
import {
  clickByAnyText,
  loginWithCredentials,
  requireEnv,
  saveStepScreenshot,
} from './helpers';

test('optional AI success: with MINIMAX_API_KEY chat returns non-error response', async ({
  page,
}) => {
  const apiKey = process.env.MINIMAX_API_KEY?.trim();
  test.skip(!apiKey, 'MINIMAX_API_KEY is not set, skipping AI success test.');

  const email = requireEnv('E2E_EMAIL');
  const password = requireEnv('E2E_PASSWORD');

  await loginWithCredentials(page, email, password);
  await clickByAnyText(page, ['AI помощник', 'AI Assistant']);
  await expect(page.getByText('AI Assistant')).toBeVisible({ timeout: 30_000 });

  const input = page.getByPlaceholder('Ask me anything...').first();
  await input.fill('Составь короткий план из 3 задач на сегодня');
  await page.getByRole('button', { name: 'Send message' }).click();

  const errorLocator = page.getByText(/AI сервис не настроен|Не удалось получить ответ AI/i);
  await page.waitForTimeout(12_000);
  await expect(errorLocator).toHaveCount(0);

  await saveStepScreenshot(page, 's6-ai-success.png');
});
