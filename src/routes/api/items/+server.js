/**
 * @type {import('./$types').RequestHandler}
 */
export async function GET() {
	const items = [
		{ id: 1, name: 'Item 1', description: 'First example item' },
		{ id: 2, name: 'Item 2', description: 'Second example item' },
		{ id: 3, name: 'Item 3', description: 'Third example item' },
	];

	return new Response(JSON.stringify(items), {
		headers: { 'Content-Type': 'application/json' },
	});
}

/**
 * @type {import('./$types').RequestHandler}
 */
export async function POST({ request }) {
	try {
		const data = await request.json();

		// Validate input
		if (!data.name || typeof data.name !== 'string') {
			return new Response(JSON.stringify({ error: 'Name is required and must be a string' }), {
				status: 400,
				headers: { 'Content-Type': 'application/json' },
			});
		}

		// Create item (in a real app, save to database)
		const newItem = {
			id: Date.now(),
			name: data.name,
			description: data.description || '',
		};

		return new Response(JSON.stringify(newItem), {
			status: 201,
			headers: { 'Content-Type': 'application/json' },
		});
	} catch (error) {
		return new Response(JSON.stringify({ error: 'Invalid request body' }), {
			status: 400,
			headers: { 'Content-Type': 'application/json' },
		});
	}
}
