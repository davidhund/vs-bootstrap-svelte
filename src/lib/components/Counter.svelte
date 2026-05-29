<!--
  Counter component demonstrating $state and reactive updates.

  This is a basic example of Svelte 5 Runes. The $state rune creates
  reactive state that automatically updates the DOM when modified.
-->

<script>
	let count = $state(0);

	function increment() {
		count++;
	}

	function decrement() {
		count--;
	}

	function reset() {
		count = 0;
	}
</script>

<div class="counter">
	<p class="counter__display">Count: {count}</p>
	<div class="counter__controls">
		<button class="counter__button" onclick={decrement}>−</button>
		<button class="counter__button counter__button--reset" onclick={reset}>Reset</button>
		<button class="counter__button" onclick={increment}>+</button>
	</div>
</div>

<style>
	.counter {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 1rem;
		padding: 1.5rem;
		border: 1px solid currentColor;
		border-radius: 0.375rem;
		opacity: 0.8;
	}

	.counter__display {
		margin: 0;
		font-size: 1.5rem;
		font-weight: 600;
	}

	.counter__controls {
		display: flex;
		gap: 0.5rem;
	}

	.counter__button {
		min-width: 3rem;
		padding: 0.5rem;
		border: 1px solid currentColor;
		border-radius: 0.25rem;
		background: transparent;
		cursor: pointer;
		font-weight: 500;
	}

	.counter__button:hover {
		background: currentColor;
		color: var(--bg, white);
	}

	.counter__button--reset {
		font-size: 0.875rem;
	}
</style>
