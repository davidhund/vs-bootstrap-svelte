# Architecture

> **Update when:** a file is added or removed · a tool or dependency changes · a convention changes · an extension point is added · the bootstrap flow changes

## Purpose

A personal project template for new SvelteKit applications. It encodes the conventions,
tooling choices, and quality defaults that apply across all projects derived from it.

---

## Tech stack

| Layer | Choice | Rationale |
|---|---|---|
| Framework | SvelteKit 2.x | SSR-first, minimal JS, excellent DX |
| UI | Svelte 5 (Runes) | Reactivity via signals; no magic |
| Build | Vite 8 | Fast HMR, ES module native |
| Type-checking | JSDoc + `jsconfig.json` | Type safety without TypeScript overhead |
| Lint + Format | Biome 2 | Single tool, fast; replaces ESLint + Prettier |
| Unit tests | Vitest 4 | Vite-native, co-located with source |
| E2E tests | Playwright | Cross-browser, first-class SvelteKit integration |
| Package manager | pnpm | Efficient disk use, strict by default |
| Adapter | `adapter-auto` | Detects deployment target at build time |

**Excluded deliberately:**
- TypeScript — JSDoc gives type safety with less friction
- Tailwind — utility classes leak design into markup; CSS custom properties preferred
- ESLint / Prettier — Biome covers both in one pass
- React / Angular — Svelte is the framework of choice per project conventions

---

## Project structure

```
src/
  app.css              ← @layer cascade architecture (reset · tokens · base)
  app.html             ← HTML shell; lang, viewport, %sveltekit.head/body%
  app.d.ts             ← SvelteKit ambient type declarations (generated)
  hooks.server.js      ← server request hook; handle + sequence stub
  lib/
    index.js           ← public API of the $lib alias; barrel-export shared utils
    utils.js           ← example utility function (replace or delete)
    utils.test.js      ← co-located Vitest unit test example
  routes/
    +layout.svelte     ← root layout; imports app.css, sets favicon
    +layout.server.js  ← root server load; data available to all pages via event.locals
    +page.svelte       ← home page (template overview + commands)
    +error.svelte      ← custom error page; handles 404 + generic errors
    demo/              ← ⚠ delete before shipping; demonstrates +page.server.js pattern
      +page.server.js
      +page.svelte
static/
  favicon.svg          ← placeholder SVG favicon; replace per project
  robots.txt
tests/
  home.e2e.js          ← Playwright smoke test (h1 visible, no console errors)
.env.example           ← env var documentation; copy to .env, never commit .env
.github/
  workflows/
    ci.yml             ← Biome + svelte-check + Vitest; Playwright excluded (see below)
.vscode/
  extensions.json      ← recommends svelte.svelte-vscode + biomejs.biome
  settings.json        ← format-on-save via Biome for all file types incl. Svelte
bin/
  create.sh            ← bootstrap script; clones template into a new project
README.template.md     ← project README stub; create.sh copies this to README.md
```

---

## Key conventions

### CSS

Global styles in `src/app.css` use `@layer` for an explicit cascade:

```
@layer reset, tokens, base;
```

| Layer | Content |
|---|---|
| `reset` | Universal resets: box-sizing, body margin, img/video max-width |
| `tokens` | CSS custom properties (`:root` block) — fill in per project |
| `base` | Element defaults using token vars — uncomment when tokens are set |

Svelte component `<style>` blocks are scoped and sit outside layers — they win over all global layers without `!important`.

- BEM (`Block__Element--Modifier`) for component class names
- No inline styles; no utility class libraries
- Targeting [Baseline 2026 Widely Available](https://web.dev/baseline) — no polyfills

### JavaScript / Svelte

- ES Modules throughout (`"type": "module"` in `package.json`)
- JSDoc for all exported functions and types: `@param`, `@returns`, `@typedef`, `@type`
- No TypeScript source files (`.ts`); the `typescript` devDep is a peer requirement for `svelte-check`
- Svelte 5 Runes: `$state`, `$derived`, `$effect`, `$props` — no legacy Svelte 4 patterns
- `PageData` type imported from `./$types` in route components (JSDoc `@type` import)

### HTML

- Lowercase elements and attributes, double quotes, tab indentation
- Semantic HTML first; no redundant ARIA (no `role="button"` on `<button>`)
- `lang="en"` on `<html>` — override per project locale

### Server / data loading

- Data flows server → page via `+page.server.js` `load()` → `data` prop
- Global data (session, user) loaded in `+layout.server.js`, stored in `event.locals` via `hooks.server.js`
- `error()` from `@sveltejs/kit` used in load functions for 4xx/5xx responses

### Testing

- **Unit tests** (`src/**/*.test.js`) — co-located with source; run via `pnpm test:unit`
- **E2E tests** (`tests/*.e2e.js`) — whole-app tests via Playwright; run locally with `pnpm test:e2e`
- **CI** runs unit tests only — Playwright excluded (browser installs are slow)

### Git

- Conventional Commits: `feat:`, `fix:`, `chore:`, `docs:`, `test:`, `refactor:`
- Feature branches; merge to `main` via PR
- No secrets or API keys committed; use `.env` (gitignored), document in `.env.example`

---

## Adapter strategy

`adapter-auto` detects the deployment environment at build time.
Supported out of the box: Vercel, Netlify, Cloudflare Pages, Azure Static Web Apps.

**To swap adapters:**
```sh
pnpm remove @sveltejs/adapter-auto
pnpm add -D @sveltejs/adapter-node    # Node.js / Docker
pnpm add -D @sveltejs/adapter-static  # Static site / CDN
```
Update the import in `svelte.config.js` accordingly.

---

## Bootstrapping a new project

The `bin/create.sh` script automates:
1. Cloning this repo to a destination (local copy or remote clone)
2. Stripping the template's git history; re-initialising on `main`
3. Replacing the project name in `package.json`
4. Copying `README.template.md` → `README.md` (with project name substituted)
5. Running `pnpm install`

```sh
./bin/create.sh ~/projects/my-new-app my-new-app
```

---

## Extension points

Intentionally **not** included — add per project via `sv add`:

| Concern | Suggested approach |
|---|---|
| Authentication | `pnpm dlx sv add better-auth` |
| Database / ORM | `pnpm dlx sv add drizzle` |
| Internationalisation | `pnpm dlx sv add paraglide` |
| CMS / Markdown | `pnpm dlx sv add mdsvex` |
| Analytics | Self-hosted only (Plausible, Umami) — no US-only or data-exfiltrating scripts |
| Design tokens | Fill in `@layer tokens` in `src/app.css` |
| Deployment adapter | Swap `adapter-auto` as needed |
| CI for E2E | Add a separate job with `playwright install --with-deps && pnpm test:e2e` |
