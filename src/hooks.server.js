/**
 * Server hooks — runs on every incoming request.
 *
 * The `handle` function intercepts requests before they reach your routes.
 * Common uses: auth/session, security headers, CORS, request logging.
 *
 * Use `sequence()` to compose multiple handle functions:
 *   import { sequence } from '@sveltejs/kit/hooks';
 *   export const handle = sequence(auth, cors, logging);
 *
 * @type {import('@sveltejs/kit').Handle}
 */
export async function handle({ event, resolve }) {
	// Example: attach data to event.locals for use in load functions
	// event.locals.user = await getUser(event.cookies.get('session'));

	const response = await resolve(event);

	// Example: add security headers to every response
	// response.headers.set('X-Frame-Options', 'SAMEORIGIN');
	// response.headers.set('X-Content-Type-Options', 'nosniff');
	// response.headers.set('Referrer-Policy', 'strict-origin-when-cross-origin');

	return response;
}
