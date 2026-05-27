<script>
	import { page } from "$app/stores";
</script>

<main class="error">
	<p class="error__status">{$page.status}</p>
	<h1 class="error__title">
		{#if $page.status === 404}
			Page not found
		{:else}
			Something went wrong
		{/if}
	</h1>
	<p class="error__message">{$page.error?.message}</p>
	<a class="error__back" href="/">Go back home</a>
</main>

<style>
	.error {
		display: grid;
		place-content: center;
		min-block-size: 100svh;
		text-align: center;
		gap: 0.5rem;
		padding: 2rem;
	}

	.error__status {
		font-size: 4rem;
		font-weight: 700;
		line-height: 1;
		opacity: 0.2;
	}

	.error__title {
		font-size: 1.5rem;
	}

	.error__message {
		opacity: 0.6;
		font-size: 0.875rem;
	}

	.error__back {
		margin-block-start: 1rem;
	}
</style>
