import { describe, expect, it } from "vitest";
import { normalizeString } from "./utils.js";

describe("normalizeString", () => {
	it("trims leading and trailing whitespace", () => {
		expect(normalizeString("  hello  ")).toBe("hello");
	});

	it("collapses internal spaces", () => {
		expect(normalizeString("hello   world")).toBe("hello world");
	});
});
