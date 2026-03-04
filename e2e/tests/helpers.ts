import { expect, Page } from '@playwright/test';
import path from 'node:path';

export function uniqueSuffix(): string {
  return Date.now().toString();
}

export async function goToLogin(page: Page): Promise<void> {
  await page.goto('/', { waitUntil: 'domcontentloaded' });
  await page.evaluate(() => {
    try {
      localStorage.clear();
      sessionStorage.clear();
    } catch (_) {
      // Ignore storage cleanup issues in strict browser contexts.
    }
  });

  const loginTitle = page.getByText('Modern CRM').first();
  const emailField = page.getByLabel('Email', { exact: false }).first();
  await Promise.race([
    loginTitle.waitFor({ state: 'visible', timeout: 90_000 }),
    emailField.waitFor({ state: 'visible', timeout: 90_000 }),
  ]);
}

export async function fillByAnyLabel(
  page: Page,
  labels: string[],
  value: string,
): Promise<void> {
  for (const label of labels) {
    const locator = page.getByLabel(label, { exact: false }).first();
    if ((await locator.count()) > 0) {
      await locator.click();
      await locator.fill(value);
      return;
    }
  }
  throw new Error(`No input found for labels: ${labels.join(', ')}`);
}

export async function clickByAnyRoleName(
  page: Page,
  names: string[],
): Promise<void> {
  for (const name of names) {
    for (const role of ['button', 'link', 'tab'] as const) {
      const locator = page.getByRole(role, { name, exact: false }).first();
      if ((await locator.count()) > 0) {
        await locator.click();
        return;
      }
    }
  }
  throw new Error(`No clickable role element for: ${names.join(', ')}`);
}

export async function clickByAnyText(
  page: Page,
  texts: string[],
): Promise<void> {
  for (const text of texts) {
    const locator = page.getByText(text, { exact: false }).first();
    if ((await locator.count()) > 0) {
      await locator.click();
      return;
    }
  }
  throw new Error(`No text target found for: ${texts.join(', ')}`);
}

export async function loginWithCredentials(
  page: Page,
  email: string,
  password: string,
): Promise<void> {
  await goToLogin(page);
  await fillByAnyLabel(page, ['Email', 'E-mail'], email);
  await fillByAnyLabel(page, ['Пароль', 'Password'], password);
  await clickByAnyRoleName(page, ['Войти', 'Login', 'Sign in']);
  await expect(page.getByText('Главная')).toBeVisible({ timeout: 90_000 });
}

export async function saveStepScreenshot(page: Page, fileName: string): Promise<void> {
  const target = path.join('artifacts', 'screenshots', fileName);
  await page.screenshot({ path: target, fullPage: true });
}

export function requireEnv(name: string): string {
  const value = process.env[name]?.trim();
  if (!value) {
    throw new Error(`${name} is required for this e2e test`);
  }
  return value;
}
