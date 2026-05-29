<!--
  SearchInput component demonstrating $state, $derived, and event binding.

  Shows how to:
  - Use $state for reactive input value
  - Use $derived to compute derived state (filtered results, character count)
  - Bind to input events
  - Display reactive results based on state changes
-->

<script>
	let query = $state('');
	let items = $state(['SvelteKit', 'Svelte', 'Vite', 'TypeScript', 'Vitest']);

	let results = $derived(
		query.length === 0 ? items : items.filter((item) => item.toLowerCase().includes(query.toLowerCase()))
	);

	let resultCount = $derived(results.length);
	let isEmpty = $derived(query.length > 0 && resultCount === 0);
</script>

<div class="search">
	<label class="search__label" for="search-input">Search:</label>
	<input
		id="search-input"
		class="search__input"
		type="text"
		placeholder="Type to filter..."
		bind:value={query}
	/>

	<p class="search__stats">
		{#if query.length > 0}
			Found {resultCount} of {items.length}
		{:else}
			{items.length} items
		{/if}
	</p>

	{#if isEmpty}
		<p class="search__empty">No matches found.</p>
	{:else}
		<ul class="search__results">
			{#each results as item (item)}
				<li class="search__result">{item}</li>
			{/each}
		</ul>
	{/if}
</div>

<style>
	.search {
		display: flex;
		flex-direction: column;
		gap: 0.75rem;
		padding: 1.5rem;
		border: 1px solid currentColor;
		border-radius: 0.375rem;
		opacity: 0.8;
	}

	.search__label {
		font-weight: 500;
		font-size: 0.875rem;
	}

	.search__input {
		padding: 0.5rem 0.75rem;
		border: 1px solid currentColor;
		border-radius: 0.25rem;
		background: transparent;
		color: inherit;
		font: inherit;
	}

	.search__input:focus {
		outline: 2px solid currentColor;
		outline-offset: 2px;
	}

	.search__stats {
		margin: 0;
		font-size: 0.875rem;
		opacity: 0.7;
	}

	.search__empty {
		margin: 0;
		font-size: 0.875rem;
		opacity: 0.6;
		font-style: italic;
	}

	.search__results {
		margin: 0;
		padding: 0;
		list-style: none;
		display: flex;
		flex-direction: column;
		gap: 0.25rem;
	}

	.search__result {
		padding: 0.5rem;
		background: currentColor;
		color: var(--bg, white);
		border-radius: 0.25rem;
		font-size: 0.875rem;
	}
</style>
