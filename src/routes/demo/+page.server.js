/**
 * Server load function — runs on the server before the page renders.
 *
 * Whatever this function returns becomes the `data` prop on the page component.
 * In a real project, replace the mock data with a DB query, fetch() call, CMS
 * request, or any other server-side data source.
 *
 * The `error()` helper (from @sveltejs/kit) can be thrown here to render
 * the +error.svelte page, e.g.:
 *   import { error } from '@sveltejs/kit';
 *   throw error(404, 'Not found');
 *
 * @returns {Promise<{ items: Array<{ id: number, title: string, description: string }> }>}
 */
export async function load() {
	// Mock data — swap for a real data source
	const items = [
		{ id: 1, title: "Server load", description: "This data was fetched on the server before the page rendered." },
		{ id: 2, title: "Type-safe", description: "The return type is inferred by SvelteKit via ./$types and JSDoc." },
		{ id: 3, title: "SSR-first", description: "No client-side fetch needed; the page is fully rendered on first load." },
	];

	return { items };
}
