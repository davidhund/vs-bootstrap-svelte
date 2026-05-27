/**
 * Root layout server load function.
 * Data returned here is available to all routes via `data` prop or `$page.data`.
 *
 * @param {import('@sveltejs/kit').ServerLoadEvent} event
 * @returns {Promise<Record<string, unknown>>}
 */
export async function load(event) {
	// Example: return global data available to all pages
	// const session = await getSession(event);
	// return { session };

	void event; // remove once event is used
	return {};
}
