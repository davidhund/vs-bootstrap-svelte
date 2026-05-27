# CLAUDE.md

Instructions for AI assistants (Claude Code and others) working in projects derived from this template.

---

## Project type

SvelteKit 2.x · Svelte 5 (Runes) · Vite 8 · JSDoc · pnpm · Biome · Vitest · Playwright

No TypeScript source files. Type safety is provided by JSDoc annotations and `svelte-check`.

---

## Workflow

1. **Plan before executing.** For any non-trivial change, outline the approach first.
2. **Ask before installing dependencies, renaming/moving files, or changing architecture.**
3. **Minimal working code first.** Avoid over-engineering; refactor only when justified.
4. **Complete the main task before fixing unrelated issues.** List discovered bugs at the end.
5. **Commit using [Conventional Commits](https://www.conventionalcommits.org/):** `feat:`, `fix:`, `chore:`, `docs:`, `test:`, `refactor:`.

---

## Toolchain quick-ref

| Command | What it does |
|---|---|
| `pnpm dev` | Start dev server at `localhost:5173` |
| `pnpm build` | Production build |
| `pnpm preview` | Preview production build |
| `pnpm check` | svelte-kit sync + svelte-check (type + template errors) |
| `pnpm lint` | Biome lint |
| `pnpm format` | Biome format (writes) |
| `pnpm test:unit` | Vitest in watch mode |
| `pnpm test:e2e` | Install Playwright browsers + run E2E |
| `pnpm test` | All tests, single run |
| `pnpm ci` | `biome ci` + `svelte-check` + unit tests |

**Run `pnpm ci` before every commit.**

---

## Code conventions

### HTML
- Semantic elements first; avoid `<div>`/`<span>` where a native element fits
- No redundant ARIA attributes (no `role="button"` on `<button>`)
- Lowercase elements and attributes, double-quoted values, tab indentation

### CSS
- **No Tailwind.** No utility classes.
- **No inline styles** (`style="..."` attribute).
- BEM naming: `Block__Element--Modifier`
- All design tokens as CSS custom properties in `src/app.css` (`:root` block)
- Target [Baseline 2026 Widely Available](https://web.dev/baseline) — no polyfills

### JavaScript / Svelte
- **No TypeScript files.** Use JSDoc for all types: `@param`, `@returns`, `@typedef`, `@type`
- ES Modules; named exports preferred over default exports in `$lib`
- Svelte 5 Runes only: `$state`, `$derived`, `$effect`, `$props` — no Svelte 4 `let` reactivity
- No framework other than SvelteKit/Svelte (no React, Vue, Angular components)

### Accessibility
- WCAG 2.2 AA minimum
- Focus management: never remove outlines without a visible replacement
- All `<img>` elements need `alt`; decorative images use `alt=""`

---

## Adapter

Default is `@sveltejs/adapter-auto`. To target a specific platform:
```sh
pnpm remove @sveltejs/adapter-auto
pnpm add -D @sveltejs/adapter-node   # or adapter-static, adapter-vercel, etc.
```
Update the import in `svelte.config.js`.

---

## Adding features

Prefer `sv add` for official integrations:
```sh
pnpm dlx sv add vitest       # unit testing
pnpm dlx sv add playwright   # E2E testing
pnpm dlx sv add drizzle      # database / ORM
pnpm dlx sv add better-auth  # authentication
pnpm dlx sv add paraglide    # i18n
pnpm dlx sv add mdsvex       # Markdown content
```

---

## What NOT to do

- Do not install ESLint, Prettier, or any linting tool other than Biome
- Do not add Tailwind or any CSS framework
- Do not commit secrets, API keys, or `.env` files
- Do not invent or hallucinate library APIs — check the docs
- Do not refactor files unrelated to the current task
- Do not add third-party scripts that send data outside the EU
