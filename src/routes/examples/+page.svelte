<!--
  Component examples demonstrating Svelte 5 Runes patterns.

  This page showcases:
  - Counter: Using $state for reactive state
  - SearchInput: Using $state + $derived for computed values

  Feel free to extend with more examples or remove this route when done.
-->

<script>
	import { resolve } from '$app/paths';
	import Counter from '$lib/components/Counter.svelte';
	import SearchInput from '$lib/components/SearchInput.svelte';
</script>

<main class="examples">
	<header class="examples__header">
		<a class="examples__back" href={resolve('/')}>← Back</a>
		<h1 class="examples__title">Component Examples</h1>
		<p class="examples__description">
			Svelte 5 Runes patterns: <code>$state</code>, <code>$derived</code>, and reactive updates.
		</p>
	</header>

	<section class="examples__section">
		<h2 class="examples__section-title">Counter with $state</h2>
		<p class="examples__section-description">
			Basic reactive state using the <code>$state</code> rune. Click buttons to update the count.
		</p>
		<Counter />
	</section>

	<section class="examples__section">
		<h2 class="examples__section-title">Search with $derived</h2>
		<p class="examples__section-description">
			Reactive derived state using <code>$derived</code>. The results automatically update as you type.
		</p>
		<SearchInput />
	</section>

	<section class="examples__section">
		<h2 class="examples__section-title">API Example</h2>
		<p class="examples__section-description">
			Try the API endpoint: <code>/api/items</code>
		</p>
		<pre class="examples__code">curl {window.location.origin}/api/items</pre>
	</section>
</main>

<style>
	.examples {
		max-inline-size: 40rem;
		margin-inline: auto;
		padding: 4rem 2rem;
		display: flex;
		flex-direction: column;
		gap: 3rem;
	}

	.examples__back {
		display: inline-block;
		margin-block-end: 0.5rem;
		font-size: 0.875rem;
	}

	.examples__title {
		font-size: 1.75rem;
		font-weight: 700;
		margin: 0;
	}

	.examples__description {
		opacity: 0.7;
		margin: 0.5rem 0 0;
	}

	.examples__section {
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.examples__section-title {
		font-size: 1.125rem;
		font-weight: 600;
		margin: 0;
	}

	.examples__section-description {
		margin: 0;
		font-size: 0.875rem;
		opacity: 0.7;
	}

	.examples__code {
		margin: 1rem 0 0;
		padding: 0.75rem;
		background: currentColor;
		color: var(--bg, white);
		border-radius: 0.375rem;
		font-size: 0.75rem;
		overflow-x: auto;
		opacity: 0.9;
	}
</style>
