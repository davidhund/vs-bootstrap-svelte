import { expect, test } from "@playwright/test";

test.describe("home page", () => {
	test("loads and renders a heading", async ({ page }) => {
		await page.goto("/");
		await expect(page.locator("h1")).toBeVisible();
	});

	test("has no console errors", async ({ page }) => {
		/** @type {string[]} */
		const errors = [];
		page.on("console", (msg) => {
			if (msg.type() === "error") errors.push(msg.text());
		});
		await page.goto("/");
		expect(errors).toHaveLength(0);
	});
});
