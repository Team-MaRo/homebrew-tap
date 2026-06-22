# AGENTS.md

Guidance for AI agents (Claude Code and others) working in this repository.

## What This Repo Is

`Team-MaRo/homebrew-tap` — a Homebrew tap (installable as `Team-MaRo/tap`). It holds **prebuilt-binary** formulae: each downloads a release binary from its source repo rather than building from source. No application code lives here.

## Structure

- `Formula/<name>.rb` — one formula per tool.
- `.github/workflows/bump-<formula>.yml` — **one bump workflow per formula**. It resolves the source repo's latest version + each release asset's sha256 **digest** (from the GitHub API — no `.sha256` files) and patches `version` + the per-platform `sha256`s in the formula. Triggered manually (`workflow_dispatch`) or by `repository_dispatch` from the source repo's release workflow.
- `.github/workflows/tests.yml`, `publish.yml` — the Homebrew `brew test-bot` / `brew pr-pull` CI (from `brew tap-new`). `tests.yml`'s tap-syntax step is inlined (`brew style`/`readall`/`audit`) rather than `brew test-bot --only-tap-syntax` so it can pass `brew audit --except=installed,version` — see the audit note below.

## How a prebuilt-binary formula works

Each formula carries `version` + per-platform `sha256` that the bump workflow keeps current. The download URLs are **version-pinned** via `#{version}` interpolation (`…/releases/download/#{version}/<asset>`) — this works because the bump sets `version` to the source release's exact tag name. Pinning the URL to the version means a bump moves the URL and its sha256 together, so there's never a `latest/download` window where the on-disk asset could mismatch the pinned sha. The formula's `install` renames the downloaded platform asset (e.g. `cc-statusline-darwin-arm64`) to the bin name.

**Audit caveat — `--except=version`.** The release assets are versionless (`cc-statusline-darwin-arm64`, not `…-0.1.2-…`). On Linux, `brew audit` reads the version straight out of the version-pinned URL *path* and flags the explicit `version` stanza as "redundant with version scanned from URL". But the stanza can't be dropped: on macOS the darwin asset name ends in `arm64`/`amd64`, so URL scanning yields a wrong version (e.g. `64`) — the explicit `version` is required for correct upgrade detection. So the redundancy is a Linux-only false positive, and the tap-syntax CI audits with `--except=version`.

A formula starts with placeholder `version "0.0.0"` + zeroed shas, so it only installs after the first successful bump against a published release.

## Adding a formula

1. Add `Formula/<name>.rb` (binary-download shape: `on_macos`/`on_linux` + `on_arm`/`on_intel`, version-pinned `releases/download/#{version}/<asset>` URLs, placeholder version/sha).
2. Copy `bump-cc-statusline.yml` → `bump-<name>.yml` and adjust `SOURCE_REPO`, the asset names, the formula path, and the `repository_dispatch` event type.
3. Run the bump workflow (or wire the source repo's release to dispatch it).

## Conventions

- Default branch is `master`. Source-repo binaries currently come from the `Team-MaRo` namespace; the source repo must be **public** for `brew install` to work for anyone but the owner. While private, the bump workflow needs the `GH_PAT` secret (a PAT with read access to the source repo).
- Workflows use `${{ github.token }}` (not `secrets.GITHUB_TOKEN`); the cross-repo PAT secret is `GH_PAT`.
