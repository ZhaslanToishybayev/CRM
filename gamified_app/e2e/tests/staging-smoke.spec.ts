import { expect, test } from '@playwright/test';

async function enableFlutterSemantics(page: import('@playwright/test').Page): Promise<void> {
  await page.waitForSelector('flutter-view', { timeout: 20_000 });

  await page.evaluate(() => {
    const placeholder = document.querySelector<HTMLElement>(
      'flt-semantics-placeholder[aria-label="Enable accessibility"]',
    );

    if (!placeholder) {
      return;
    }

    placeholder.dispatchEvent(
      new MouseEvent('click', { bubbles: true, cancelable: true, view: window }),
    );
    placeholder.click();
  });

  // Allow Flutter to rebuild semantics tree after accessibility is enabled.
  await page.waitForTimeout(1_000);
}

test.describe('Staging Smoke', () => {
  test('loads login and enters demo mode', async ({ page }) => {
    await page.goto('/');
    await enableFlutterSemantics(page);

    await expect(page.getByRole('button', { name: 'Try Demo Mode' })).toBeVisible({
      timeout: 20_000,
    });

    await page.getByRole('button', { name: 'Try Demo Mode' }).click();

    await page.waitForURL(/\/tasks/, { timeout: 30_000 });
    await expect(page.getByText(/Welcome,/)).toBeVisible();
    await expect(
      page.getByText('Your Stats').or(page.getByText('No tasks yet. Tap + to add one!')),
    ).toBeVisible();
  });

  test('authenticates with staging credentials when provided', async ({ page }) => {
    const email = process.env.E2E_EMAIL;
    const password = process.env.E2E_PASSWORD;

    test.skip(!email || !password, 'E2E_EMAIL/E2E_PASSWORD are not configured');

    await page.goto('/');
    await enableFlutterSemantics(page);

    await page.getByLabel('Email').fill(email!);
    await page.getByLabel('Password').fill(password!);
    await page.getByRole('button', { name: 'Sign In' }).click();

    await page.waitForURL(/\/tasks/, { timeout: 30_000 });
    await expect(page.getByText(/Welcome,/)).toBeVisible();
  });

  test('can sign out from tasks screen', async ({ page }) => {
    await page.goto('/');
    await enableFlutterSemantics(page);
    await page.getByRole('button', { name: 'Try Demo Mode' }).click();
    await page.waitForURL(/\/tasks/, { timeout: 30_000 });

    await page.getByRole('button', { name: 'Sign Out' }).click();
    await page.waitForURL(/\/login/, { timeout: 30_000 });
    await expect(page.getByRole('button', { name: 'Try Demo Mode' })).toBeVisible();
  });
});
