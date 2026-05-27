# Architecture

> Living document. Update when architectural decisions change.

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
| Lint + Format | Biome 2 | Single tool, fast, replaces ESLint + Prettier |
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
  app.css             ← global CSS; design token `:root` block lives here
  app.html            ← HTML shell; lang, viewport, %sveltekit.head/body%
  lib/
    index.js          ← public API of the $lib alias; barrel-export shared utils
    assets/           ← images, SVGs, fonts imported by components
  routes/
    +layout.svelte    ← root layout; imports app.css, sets favicon
    +page.svelte      ← home page
    demo/             ← scaffold demo pages; delete before shipping
tests/
  *.e2e.js            ← Playwright E2E tests
bin/
  create.sh           ← bootstrap script; clones template into a new project
```

---

## Key conventions

### CSS
- All global design tokens declared as CSS custom properties in `src/app.css`
- BEM (`Block__Element--Modifier`) for component class names
- No inline styles; no utility class libraries
- Targeting [Baseline 2026 Widely Available](https://web.dev/baseline) — no polyfills

### JavaScript
- ES Modules throughout (`"type": "module"` in `package.json`)
- JSDoc for all exported functions and types; `@param`, `@returns`, `@typedef`
- No TypeScript source files (`.ts`/`.tsx`); the `typescript` devDep is a peer requirement for `svelte-check`
- Svelte 5 Runes (`$state`, `$derived`, `$effect`, `$props`) — no legacy Svelte 4 patterns

### HTML
- Lowercase elements and attributes, double quotes
- Tabs for indentation
- No redundant ARIA; prefer semantic HTML (no `role="button"` on `<button>`)
- `lang="en"` on `<html>` (override per project locale)

### Git
- Conventional Commits: `feat:`, `fix:`, `chore:`, `docs:`, `test:`
- Feature branches; merge to `main` via PR
- No secrets or API keys committed

---

## Adapter strategy

`adapter-auto` detects the deployment environment from environment variables at build time.
Supported targets out of the box: Vercel, Netlify, Cloudflare Pages, Azure Static Web Apps.

**To swap adapters:**
```sh
pnpm remove @sveltejs/adapter-auto
pnpm add -D @sveltejs/adapter-node   # Node.js / Docker
pnpm add -D @sveltejs/adapter-static # Static site / CDN
```
Update the import in `svelte.config.js` accordingly.

---

## Bootstrapping a new project

The `bin/create.sh` script automates:
1. Cloning this repo to a destination directory
2. Stripping the template's git history
3. Initialising a fresh git repo on `main`
4. Replacing the project name in `package.json`
5. Running `pnpm install`

See [README.md](README.md) for usage.

---

## Extension points

These are intentionally **not** included in the template. Add them per project:

| Concern | Suggested approach |
|---|---|
| Authentication | `better-auth` (`sv add better-auth`) |
| Database / ORM | `drizzle` (`sv add drizzle`) |
| Internationalisation | `paraglide` (`sv add paraglide`) |
| CMS / content | `mdsvex` for Markdown; headless CMS per project |
| Analytics | Self-hosted (Plausible, Umami) — no US-only or data-exfiltrating scripts |
| Design tokens | Fill in `src/app.css` `:root` block |
| Deployment adapter | Swap `adapter-auto` as needed |
