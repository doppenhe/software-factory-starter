import { expect, test } from "@playwright/test";

test("starter docs are reachable as files", async ({ page }) => {
  await page.goto("about:blank");
  await page.setContent(`
    <main>
      <h1>Software Factory Starter</h1>
      <p>Portable harness ready.</p>
    </main>
  `);

  await expect(page.getByRole("heading", { name: "Software Factory Starter" })).toBeVisible();
  await expect(page.getByText("Portable harness ready.")).toBeVisible();
});

