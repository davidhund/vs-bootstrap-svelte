/**
 * Formats a string by trimming whitespace and collapsing internal spaces.
 * Replace or extend this with your own utilities.
 *
 * @param {string} str
 * @returns {string}
 */
export function normalizeString(str) {
	return str.trim().replace(/\s+/g, " ");
}
