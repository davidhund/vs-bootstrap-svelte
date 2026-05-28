<!-- Update when: commands change · stack changes · setup steps change -->
# PROJECT_NAME

Short description of what this project does.

## Stack

<!-- Fill in or remove -->
| Tool | Version | Purpose |
|---|---|---|
| SvelteKit | 2.x | Framework |
| Svelte | 5 · Runes | UI |
| Vite | 8 | Build |
| Biome | 2 | Lint + format |

---

## Development

```sh
pnpm dev          # dev server → localhost:5173
pnpm dev --open   # open in browser
```

## Commands

```sh
pnpm lint         # Biome lint
pnpm format       # Biome format (writes in-place)
pnpm check        # svelte-kit sync + svelte-check

pnpm test:unit    # Vitest (watch mode)
pnpm test:e2e     # Playwright E2E  ← local only, not in CI
pnpm test         # unit + E2E, single run  ← local only
pnpm ci           # lint + check + unit tests

pnpm build        # production build
pnpm preview      # preview production build
```

---

---

## AI-assisted development

This template includes Svelte MCP (Model Context Protocol) setup for AI-assisted development with Claude Code. See the [original template README](https://github.com/davidhund/vs-bootstrap-svelte#ai-assisted-development) for one-time setup instructions (takes ~2 min).

---

<!-- Remove this section once the demo route is deleted -->
## Template demo

Visit `/demo` to see the `+page.server.js` data-loading pattern.
Delete `src/routes/demo/` when you no longer need it.
