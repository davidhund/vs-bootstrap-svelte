<!-- Update when: commands change · project structure changes · stack versions change · bootstrap steps change -->
# vs-bootstrap-svelte

A personal SvelteKit starter template. Use this to bootstrap new projects — it comes pre-configured with the tooling and conventions I use across projects.

## Stack

| Tool | Version | Purpose |
|---|---|---|
| [SvelteKit](https://svelte.dev/docs/kit) | 2.x | Framework (SSR-first) |
| [Svelte](https://svelte.dev) | 5 · Runes | UI / reactivity |
| [Vite](https://vite.dev) | 8 | Dev server & build |
| [Biome](https://biomejs.dev) | 2 | Lint + format (replaces ESLint + Prettier) |
| [Vitest](https://vitest.dev) | 4 | Unit tests (co-located with source) |
| [Playwright](https://playwright.dev) | 1.x | E2E tests (`tests/`) |

Type-checking: JSDoc + `svelte-check` — no TypeScript source files.

---

## Bootstrap a new project

```sh
git clone https://github.com/davidhund/vs-bootstrap-svelte.git
cd vs-bootstrap-svelte
./bin/create.sh ~/projects/my-new-app my-new-app
```

`bin/create.sh` will:
1. Copy the template to the destination
2. Strip the template's git history; re-init on `main`
3. Rename the project in `package.json`
4. Replace `README.md` with a clean project stub (`README.template.md`)
5. Run `pnpm install`

---

## Commands

```sh
pnpm dev          # dev server → localhost:5173
pnpm build        # production build
pnpm preview      # preview production build

pnpm lint         # Biome lint
pnpm format       # Biome format (writes in-place)
pnpm check        # svelte-kit sync + svelte-check

pnpm test:unit    # Vitest (watch mode)
pnpm test:e2e     # install Playwright browsers + run E2E  ← local only
pnpm test         # unit + E2E, single run                 ← local only
pnpm ci           # lint + check + unit tests              ← no Playwright
```

> **Note:** `pnpm test:e2e` is not run in CI — browser installs are slow.
> Run E2E locally or add a dedicated pipeline step per project.

---

## Project structure

```
src/
  app.css             ← @layer CSS architecture (reset, tokens, base)
  app.html            ← HTML shell
  hooks.server.js     ← server request hook (handle, sequence)
  lib/
    index.js          ← $lib barrel exports
    utils.js          ← example utility — replace or delete
    utils.test.js     ← Vitest unit test example
  routes/
    +layout.svelte    ← root layout; imports app.css, sets favicon
    +layout.server.js ← root server load (data available to all pages)
    +page.svelte      ← home page
    +error.svelte     ← custom error page (404 + generic)
    demo/             ← ⚠ delete when done; shows server load pattern
static/
  favicon.svg
  robots.txt
tests/
  home.e2e.js         ← Playwright smoke test
.github/
  workflows/
    ci.yml            ← Biome + svelte-check + unit tests
.vscode/
  extensions.json     ← recommends Svelte + Biome extensions
  settings.json       ← format-on-save via Biome
bin/
  create.sh           ← bootstrap script
```

---

## AI-assisted development

This template is optimized for working with Claude Code and other AI assistants through the **Svelte MCP** (Model Context Protocol):

- **Live documentation:** The MCP server pulls current Svelte 5 and SvelteKit docs at request time — no stale training data
- **Code validation:** The `svelte-autofixer` tool catches subtle Runes mistakes (incorrect `$state` usage, `$effect` vs `$derived` confusion, etc.)
- **Auto-reminders:** When you edit `.svelte` files, Claude is reminded to use Svelte-specific skills
- **Best practices:** The included skills encode canonical Svelte 5 patterns (reactivity, events, styling, component design)

This is especially valuable for:
- Catching Svelte 4 → 5 migration mistakes
- Using modern Runes patterns correctly (`$state`, `$derived`, `$effect`, `$props`)
- Validating component code before committing
- Getting accurate, up-to-date docs without manual lookups

### Setup (one-time)

#### 1. Register the MCP server with Claude Code

```sh
claude mcp add -t http -s user svelte https://mcp.svelte.dev/mcp
```

This adds the Svelte MCP server at user level (available across all your projects).

#### 2. Install Svelte skills to `~/.claude/skills/`

Download the two Svelte skills from the official repository:

```sh
# svelte-code-writer skill
mkdir -p ~/.claude/skills/svelte-code-writer
curl -s https://raw.githubusercontent.com/sveltejs/ai-tools/main/tools/skills/svelte-code-writer/SKILL.md \
  > ~/.claude/skills/svelte-code-writer/SKILL.md

# svelte-core-bestpractices skill
mkdir -p ~/.claude/skills/svelte-core-bestpractices
curl -s https://raw.githubusercontent.com/sveltejs/ai-tools/main/tools/skills/svelte-core-bestpractices/SKILL.md \
  > ~/.claude/skills/svelte-core-bestpractices/SKILL.md
```

Both skills will now be available in Claude Code sessions.

#### 3. Done!

The auto-trigger hook is already configured in `.claude/settings.json` — when you edit `.svelte` files, Claude will automatically be reminded to use these skills.

---

See [CLAUDE.md](./CLAUDE.md#svelte-ai-tools-mcp) for usage details and examples.

---

## CSS architecture

`src/app.css` uses `@layer` to make the cascade explicit:

| Layer | Active rules | Purpose |
|---|---|---|
| `reset` | box-sizing, body margin, img/video | Universal resets |
| `tokens` | — (commented) | CSS custom property definitions |
| `base` | — (commented) | Element defaults consuming tokens |

Svelte component `<style>` blocks sit outside layers and automatically win — no `!important` needed.

---

## Adapters

Default: `adapter-auto` (auto-detects Vercel, Netlify, Cloudflare, etc.).

To target a specific platform:
```sh
pnpm remove @sveltejs/adapter-auto
pnpm add -D @sveltejs/adapter-node    # Node.js / Docker
pnpm add -D @sveltejs/adapter-static  # static site / CDN
```
Update the import in `svelte.config.js`.

---

## License

MIT © 2026 David Hund
