<script>
	import { resolve } from '$app/paths';
</script>

<main class="home">
	<header class="home__header">
		<h1 class="home__title">vs-bootstrap-svelte</h1>
		<p class="home__tagline">SvelteKit project template</p>
	</header>

	<section class="home__stack" aria-label="Tech stack">
		<h2 class="home__section-title">Stack</h2>
		<dl class="stack">
			<div class="stack__item">
				<dt class="stack__name">Framework</dt>
				<dd class="stack__value">SvelteKit 2 · Svelte 5 Runes · Vite 8</dd>
			</div>
			<div class="stack__item">
				<dt class="stack__name">Language</dt>
				<dd class="stack__value">JavaScript + JSDoc (no TypeScript)</dd>
			</div>
			<div class="stack__item">
				<dt class="stack__name">Lint + Format</dt>
				<dd class="stack__value">Biome v2</dd>
			</div>
			<div class="stack__item">
				<dt class="stack__name">Testing</dt>
				<dd class="stack__value">Vitest (unit) · Playwright (E2E)</dd>
			</div>
			<div class="stack__item">
				<dt class="stack__name">Adapter</dt>
				<dd class="stack__value">adapter-auto</dd>
			</div>
		</dl>
	</section>

	<section class="home__commands" aria-label="Useful commands">
		<h2 class="home__section-title">Commands</h2>
		<dl class="stack">
			<div class="stack__item">
				<dt class="stack__name"><code>pnpm dev</code></dt>
				<dd class="stack__value">Start dev server</dd>
			</div>
			<div class="stack__item">
				<dt class="stack__name"><code>pnpm lint</code></dt>
				<dd class="stack__value">Biome lint</dd>
			</div>
			<div class="stack__item">
				<dt class="stack__name"><code>pnpm check</code></dt>
				<dd class="stack__value">svelte-check</dd>
			</div>
			<div class="stack__item">
				<dt class="stack__name"><code>pnpm test:unit</code></dt>
				<dd class="stack__value">Vitest (watch)</dd>
			</div>
			<div class="stack__item">
				<dt class="stack__name"><code>pnpm ci</code></dt>
				<dd class="stack__value">Lint + check + unit tests</dd>
			</div>
		</dl>
	</section>

	<footer class="home__footer">
		<a href="https://kit.svelte.dev/docs">SvelteKit docs</a>
		<a href={resolve('/demo')}>Demo: server load →</a>
		<a href={resolve('/examples')}>Component examples →</a>
	</footer>
</main>

<style>
	.home {
		max-inline-size: 40rem;
		margin-inline: auto;
		padding: 4rem 2rem;
		display: flex;
		flex-direction: column;
		gap: 3rem;
	}

	.home__title {
		font-size: 2rem;
		font-weight: 700;
		line-height: 1.1;
	}

	.home__tagline {
		opacity: 0.6;
		margin-block-start: 0.25rem;
	}

	.home__section-title {
		font-size: 0.75rem;
		font-weight: 600;
		text-transform: uppercase;
		letter-spacing: 0.08em;
		opacity: 0.5;
		margin-block-end: 0.75rem;
	}

	.stack {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
	}

	.stack__item {
		display: flex;
		gap: 1rem;
		align-items: baseline;
	}

	.stack__name {
		min-inline-size: 10rem;
		font-weight: 500;
	}

	.stack__value {
		opacity: 0.7;
	}

	.home__footer {
		display: flex;
		gap: 1.5rem;
		font-size: 0.875rem;
	}
</style>
