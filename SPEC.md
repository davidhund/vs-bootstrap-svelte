# Spec

> Living document. Describes what this template provides and the standards derived projects must meet.

---

## Goals

- Provide a ready-to-run SvelteKit project in under a minute (`./bin/create.sh`)
- Encode quality defaults so new projects start compliant, not aspirationally
- Be opinionated on tooling, unopinionated on application domain

## Non-goals

- Application-level features (auth, DB, routing patterns, i18n) — see ARCHITECTURE.md extension points
- Design system or component library — only structural conventions are included
- CI/CD pipeline — add per project

---

## Template requirements

### Framework
- SvelteKit 2.x with Svelte 5 (Runes mode enforced via `svelte.config.js`)
- SSR enabled by default (no `export const ssr = false` unless intentional)
- `adapter-auto` as the default deployment adapter

### Language
- JavaScript with JSDoc type annotations (no `.ts` source files)
- `jsconfig.json` for editor and `svelte-check` type resolution
- ES Modules (`"type": "module"`)

### CSS
- `src/app.css` imported in the root layout; contains only a design token comment scaffold
- No framework CSS, no Tailwind, no inline styles
- Custom properties pattern for design tokens (`:root { --token: value; }`)

### Tooling
| Tool | Requirement |
|---|---|
| pnpm | Package manager; `engine-strict=true` in `.npmrc` |
| Biome | Lint + format; `pnpm lint` and `pnpm format` must pass on a clean scaffold |
| svelte-check | `pnpm check` must pass with zero errors on a clean scaffold |
| Vitest | `pnpm test:unit` must run; scaffold includes at least one passing example |
| Playwright | `pnpm test:e2e` must run; scaffold includes a home-page smoke test |

### Scripts (required in `package.json`)

| Script | Command |
|---|---|
| `dev` | `vite dev` |
| `build` | `vite build` |
| `preview` | `vite preview` |
| `check` | `svelte-kit sync && svelte-check` |
| `lint` | `biome lint .` |
| `format` | `biome format . --write` |
| `test:unit` | `vitest` |
| `test:e2e` | `playwright install && playwright test` |
| `test` | unit + e2e, single run |
| `ci` | `biome ci` + `check` + `test:unit` |

---

## Accessibility

- WCAG 2.2 Level AA minimum for all scaffold pages
- Semantic HTML; no `<div>` or `<span>` where a native element fits
- Focus management: no removal of focus outlines without replacement
- Colour contrast: meet 4.5:1 (normal text) and 3:1 (large text / UI components)
- All images must have meaningful `alt`; decorative images use `alt=""`

---

## Performance

- Core Web Vitals targets: LCP < 2.5s, CLS < 0.1, INP < 200ms
- No render-blocking third-party scripts
- No analytics or font services that exfiltrate data outside the EU
- Prefer system fonts; self-host web fonts if required
- Lazy-load images below the fold; use `loading="lazy"` + `width`/`height` attributes

---

## Browser baseline

Target: **[Baseline 2026 Widely Available](https://web.dev/baseline)**

- No polyfills for features available in all modern evergreen browsers
- Progressive enhancement for anything outside baseline
- Test in: Chrome, Firefox, Safari (macOS + iOS), Edge

---

## Testing strategy

### Unit tests (Vitest)
- Co-located alongside source: `src/**/*.{test,spec}.js`
- Test pure functions, utilities, and business logic
- Component rendering tests only if logic is non-trivial
- `requireAssertions: true` — every test must assert something

### E2E tests (Playwright)
- Located in `tests/`
- Cover user-visible flows, not implementation details
- Minimum: home page loads, no JS errors in console
- Run against the dev server (`webServer` config in `playwright.config.js`)

---

## Bootstrap script spec (`bin/create.sh`)

| Behaviour | Requirement |
|---|---|
| Invocation | `./bin/create.sh <dest-path> [project-name]` |
| Guard | Refuse if `<dest-path>` already exists and is non-empty |
| Source | Clone from this repo's remote URL; fall back to local copy if offline |
| De-git | Remove `<dest>/.git`; run `git init`; create branch `main` |
| Rename | Replace `"name": "vs-bootstrap-svelte"` in `package.json` with the supplied name (or basename of path) |
| Install | Run `pnpm install` in the new project |
| Output | Print a "next steps" summary: `cd <dest>`, `pnpm dev` |
| Dependencies | Plain bash only — no Node, no external tools beyond `git` and `pnpm` |
