# AGENTS.md

Guidance for AI agents (Claude Code and others) working in this repository.

## What This Repo Is

`Team-MaRo/homebrew-tap` — a Homebrew tap (installable as `Team-MaRo/tap`). It holds **prebuilt-binary** formulae: each downloads a release binary from its source repo rather than building from source. No application code lives here.

## Structure

- `Formula/<name>.rb` — one formula per tool.
- `.github/workflows/bump-<formula>.yml` — **one bump workflow per formula**. It resolves the source repo's latest version + each release asset's sha256 **digest** (from the GitHub API — no `.sha256` files) and patches `version` + the per-platform `sha256`s in the formula. Triggered manually (`workflow_dispatch`) or by `repository_dispatch` from the source repo's release workflow.
- `.github/workflows/tests.yml`, `publish.yml` — the standard Homebrew `brew test-bot` / `brew pr-pull` CI (from `brew tap-new`).

## How a prebuilt-binary formula works

The release assets are **versionless** (`…/releases/latest/download/<asset>`, overwritten each release), so the formula can't auto-pin them — it carries `version` + `sha256` that the bump workflow keeps current. The formula's `install` renames the downloaded platform asset (e.g. `cc-statusline-darwin-arm64`) to the bin name. `brew audit --strict` may warn that the stable URL isn't version-pinned; that's expected for this scheme and doesn't block install.

A formula starts with placeholder `version "0.0.0"` + zeroed shas, so it only installs after the first successful bump against a published release.

## Adding a formula

1. Add `Formula/<name>.rb` (binary-download shape: `on_macos`/`on_linux` + `on_arm`/`on_intel`, versionless `latest/download` URLs, placeholder version/sha).
2. Copy `bump-cc-statusline.yml` → `bump-<name>.yml` and adjust `SOURCE_REPO`, the asset names, the formula path, and the `repository_dispatch` event type.
3. Run the bump workflow (or wire the source repo's release to dispatch it).

## Conventions

- Default branch is `master`. Source-repo binaries currently come from the `Team-MaRo` namespace; the source repo must be **public** for `brew install` to work for anyone but the owner. While private, the bump workflow needs the `GH_PAT` secret (a PAT with read access to the source repo).
- Workflows use `${{ github.token }}` (not `secrets.GITHUB_TOKEN`); the cross-repo PAT secret is `GH_PAT`.
