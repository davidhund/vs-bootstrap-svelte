# vs-bootstrap-svelte

A personal SvelteKit starter template. Use this to bootstrap new projects — it comes pre-configured with the tooling and conventions I use across projects.

## Stack

| Tool | Version | Purpose |
|---|---|---|
| [SvelteKit](https://kit.svelte.dev) | 2.x | Framework |
| [Svelte](https://svelte.dev) | 5 (Runes) | UI |
| [Vite](https://vite.dev) | 8 | Dev server & build |
| [Biome](https://biomejs.dev) | 2 | Lint + format |
| [Vitest](https://vitest.dev) | 4 | Unit tests |
| [Playwright](https://playwright.dev) | 1.x | E2E tests |

Type-checking via JSDoc + `svelte-check` (no TypeScript).

---

## Bootstrap a new project

Clone this repo and run the bootstrap script, pointing it at your new project destination:

```sh
git clone https://github.com/davidhund/vs-bootstrap-svelte.git
cd vs-bootstrap-svelte
./bin/create.sh ~/projects/my-new-app my-new-app
```

The script will:
1. Copy the template to the destination
2. Strip the template's git history and re-init
3. Rename the project in `package.json`
4. Run `pnpm install`

---

## Development

```sh
pnpm dev          # start dev server at localhost:5173
pnpm dev --open   # open in browser automatically
```

## Testing

```sh
pnpm test:unit    # run Vitest unit tests (watch mode)
pnpm test:e2e     # install Playwright browsers + run E2E tests
pnpm test         # run all tests once
```

## Lint & format

```sh
pnpm lint         # Biome lint
pnpm format       # Biome format (writes)
pnpm check        # svelte-check (type + template errors)
```

## CI

```sh
pnpm ci           # biome ci + svelte-check + unit tests
```

## Build

```sh
pnpm build        # production build
pnpm preview      # preview production build locally
```

---

## Project structure

```
src/
  app.css             ← design token layer (fill this in per project)
  app.html            ← HTML shell
  lib/
    index.js          ← shared library exports
  routes/
    +layout.svelte    ← root layout
    +page.svelte      ← home page
tests/                ← Playwright E2E tests
bin/
  create.sh           ← bootstrap script
```

---

## Adapters

Default adapter is `adapter-auto`. To target a specific platform, swap it in `svelte.config.js`:

```sh
pnpm add -D @sveltejs/adapter-node   # Node.js
pnpm add -D @sveltejs/adapter-static # Static / SSG
```

See [SvelteKit adapters](https://svelte.dev/docs/kit/adapters) for the full list.

---

## License

MIT © 2026 David Hund
