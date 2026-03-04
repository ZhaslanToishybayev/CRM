import { test, expect } from '@playwright/test';
import {
  clickByAnyRoleName,
  clickByAnyText,
  fillByAnyLabel,
  loginWithCredentials,
  requireEnv,
  saveStepScreenshot,
  uniqueSuffix,
} from './helpers';

test('S1-S4 browser flow: login -> create client -> create linked task -> verify in client details', async ({
  page,
}) => {
  const email = requireEnv('E2E_EMAIL');
  const password = requireEnv('E2E_PASSWORD');

  const suffix = uniqueSuffix();
  const firstName = `E2E${suffix}`;
  const lastName = 'User';
  const fullName = `${firstName} ${lastName}`;
  const clientEmail = `e2e.client.${suffix}@example.com`;
  const taskTitle = `E2E linked task ${suffix}`;

  await loginWithCredentials(page, email, password);
  await saveStepScreenshot(page, 's1-login-success.png');

  await clickByAnyText(page, ['CRM']);
  await clickByAnyRoleName(page, ['Добавить клиента', 'Add client']);

  await fillByAnyLabel(page, ['Имя', 'First Name'], firstName);
  await fillByAnyLabel(page, ['Фамилия', 'Last Name'], lastName);
  await fillByAnyLabel(page, ['Email', 'E-mail'], clientEmail);
  await fillByAnyLabel(page, ['Телефон', 'Phone'], '+77011234567');

  await clickByAnyRoleName(page, ['Создать Клиента', 'Create Client', 'Сохранить']);
  await expect(page.getByText(fullName)).toBeVisible({ timeout: 30_000 });
  await saveStepScreenshot(page, 's2-client-created.png');

  await clickByAnyText(page, ['Задачи', 'Tasks']);
  await clickByAnyRoleName(page, ['Добавить задачу', 'Add task']);

  await fillByAnyLabel(page, ['Название задачи', 'Task Title'], taskTitle);
  await fillByAnyLabel(page, ['Описание', 'Description'], 'Created by Playwright e2e');

  await clickByAnyText(page, [
    'Выберите клиента или No client',
    'Выберите клиента или общий тип задачи',
    'No client (general task)',
  ]);
  await clickByAnyText(page, [fullName]);

  await clickByAnyRoleName(page, ['Создать задачу', 'Create Task', 'Сохранить']);
  await expect(page.getByText(taskTitle)).toBeVisible({ timeout: 30_000 });
  await expect(page.getByText(`Клиент: ${fullName}`)).toBeVisible({ timeout: 30_000 });
  await saveStepScreenshot(page, 's3-linked-task-created.png');

  await clickByAnyText(page, ['CRM']);
  await clickByAnyText(page, [fullName]);
  await expect(page.getByText('Связанные задачи')).toBeVisible({ timeout: 30_000 });
  await expect(page.getByText(taskTitle)).toBeVisible({ timeout: 30_000 });
  await saveStepScreenshot(page, 's4-client-linked-tasks.png');
});
