<!--
  DEMO: +page.server.js data loading
  ====================================
  Pattern:
    1. +page.server.js exports a `load` function that runs server-side
    2. Its return value is typed via SvelteKit's generated ./$types
    3. The page receives it as the `data` prop via $props() (Svelte 5 Runes)
    4. Render with {#each} as usual

  Delete this route (src/routes/demo/) once you have your own pages.
-->

<script>
	/** @type {{ data: import('./$types').PageData }} */
	let { data } = $props();
</script>

<main class="demo">
	<header class="demo__header">
		<a class="demo__back" href="/">← Back</a>
		<h1 class="demo__title">Demo: server load</h1>
		<p class="demo__description">
			Data below was loaded in <code>+page.server.js</code> before this page rendered.
		</p>
	</header>

	<ul class="demo__list">
		{#each data.items as item (item.id)}
			<li class="demo__item">
				<strong class="demo__item-title">{item.title}</strong>
				<p class="demo__item-description">{item.description}</p>
			</li>
		{/each}
	</ul>
</main>

<style>
	.demo {
		max-inline-size: 40rem;
		margin-inline: auto;
		padding: 4rem 2rem;
		display: flex;
		flex-direction: column;
		gap: 2rem;
	}

	.demo__back {
		display: inline-block;
		margin-block-end: 0.5rem;
		font-size: 0.875rem;
	}

	.demo__title {
		font-size: 1.75rem;
		font-weight: 700;
		margin: 0;
	}

	.demo__description {
		opacity: 0.7;
		margin: 0.5rem 0 0;
	}

	.demo__list {
		list-style: none;
		padding: 0;
		margin: 0;
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.demo__item {
		padding: 1rem 1.25rem;
		border: 1px solid currentColor;
		border-radius: 0.375rem;
		opacity: 0.8;
	}

	.demo__item-title {
		display: block;
		margin-block-end: 0.25rem;
	}

	.demo__item-description {
		margin: 0;
		font-size: 0.875rem;
		opacity: 0.7;
	}
</style>
