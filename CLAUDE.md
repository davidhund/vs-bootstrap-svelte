# CLAUDE.md

Instructions for AI assistants (Claude Code and others) working in projects derived from this template.

---

## Project type

SvelteKit 2.x · Svelte 5 (Runes) · Vite 8 · JSDoc · pnpm · Biome · Vitest · Playwright

No TypeScript source files. Type safety via JSDoc annotations + `svelte-check`.

---

## Workflow

1. **Plan before executing.** Outline the approach for any non-trivial change.
2. **Ask before** installing dependencies, renaming/moving files, or changing architecture.
3. **Minimal working code first.** Avoid over-engineering; refactor only when justified.
4. **Finish the main task before fixing unrelated issues.** List discovered bugs at the end.
5. **Commit with [Conventional Commits](https://www.conventionalcommits.org/):** `feat:`, `fix:`, `chore:`, `docs:`, `test:`, `refactor:`.

---

## Toolchain quick-ref

| Command | What it does |
|---|---|
| `pnpm dev` | Start dev server at `localhost:5173` |
| `pnpm build` | Production build |
| `pnpm preview` | Preview production build |
| `pnpm check` | svelte-kit sync + svelte-check (type + template errors) |
| `pnpm lint` | Biome lint |
| `pnpm format` | Biome format (writes in-place) |
| `pnpm test:unit` | Vitest in watch mode |
| `pnpm test:e2e` | Install Playwright browsers + run E2E — **local only, not in CI** |
| `pnpm test` | All tests, single run — **local only** |
| `pnpm ci` | `biome ci` + `svelte-check` + unit tests — **no Playwright** |

**Run `pnpm ci` before every commit.**

E2E tests are intentionally excluded from `pnpm ci` and the GitHub Actions workflow — browser installs are slow. Run `pnpm test:e2e` locally, or add a dedicated job per project.

---

## Key files

| File | Purpose |
|---|---|
| `src/app.css` | Global CSS: `@layer reset, tokens, base` — fill in tokens per project |
| `src/hooks.server.js` | Server request hook — add auth, headers, logging here |
| `src/routes/+layout.server.js` | Root server load — return data available to all pages |
| `src/routes/+error.svelte` | Custom error page — handles 404 and generic errors |
| `src/routes/demo/` | ⚠ Demo only — delete when no longer needed as reference |
| `.env.example` | Document all env vars here; copy to `.env` to use |

---

## Code conventions

### HTML
- Semantic elements first; avoid `<div>`/`<span>` where a native element fits
- No redundant ARIA attributes (`role="button"` on `<button>` is wrong)
- Lowercase elements and attributes, double-quoted values, tab indentation

### CSS
- **No Tailwind.** No utility classes. No inline `style="..."` attributes.
- BEM class names: `Block__Element--Modifier`
- Design tokens as CSS custom properties in `src/app.css` under `@layer tokens`
- Global styles use `@layer` — component `<style>` blocks are scoped and win automatically
- Target [Baseline 2026 Widely Available](https://web.dev/baseline) — no polyfills

### JavaScript / Svelte
- **No TypeScript files.** JSDoc for all types: `@param`, `@returns`, `@typedef`, `@type`
- ES Modules; named exports preferred over default exports in `$lib`
- Svelte 5 Runes only: `$state`, `$derived`, `$effect`, `$props` — no legacy `let` reactivity
- Route components: import `PageData` / `LayoutData` from `./$types` for typed `data` prop
- No framework other than SvelteKit/Svelte (no React, Vue, Angular)

### Accessibility
- WCAG 2.2 AA minimum
- Never remove focus outlines without a visible replacement
- All `<img>` need `alt`; decorative images use `alt=""`

---

## Server patterns

```js
// +page.server.js — load data server-side
export async function load({ params, locals }) {
  return { items: [] }; // becomes the `data` prop
}

// +page.svelte — consume typed data
/** @type {{ data: import('./$types').PageData }} */
let { data } = $props();

// hooks.server.js — intercept every request
export async function handle({ event, resolve }) {
  event.locals.user = await getUser(event);
  return resolve(event);
}
```

---

## Adapter

Default: `@sveltejs/adapter-auto` (detects Vercel, Netlify, Cloudflare, etc.).

To target a specific platform:
```sh
pnpm remove @sveltejs/adapter-auto
pnpm add -D @sveltejs/adapter-node   # or adapter-static, adapter-vercel, etc.
```
Update the import in `svelte.config.js`.

---

## Adding features

Use `sv add` for official SvelteKit integrations:
```sh
pnpm dlx sv add drizzle      # database / ORM
pnpm dlx sv add better-auth  # authentication
pnpm dlx sv add paraglide    # i18n
pnpm dlx sv add mdsvex       # Markdown content
```

Vitest and Playwright are already installed — do not add them again.

---

## What NOT to do

- Do not install ESLint, Prettier, or any linting tool other than Biome
- Do not add Tailwind or any CSS framework
- Do not use inline styles or non-BEM class names in new components
- Do not commit `.env` files, secrets, or API keys
- Do not invent or hallucinate library APIs — check the docs
- Do not refactor files unrelated to the current task
- Do not add third-party scripts that send data outside the EU
