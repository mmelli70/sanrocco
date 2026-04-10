# Copilot Instructions

## Overview

This repository uses **speckit** (v0.6.1.dev0), an AI-assisted specification-driven development workflow integrated with GitHub Copilot. The project has no application source code yet — speckit orchestrates the process of writing specs, plans, tasks, and ultimately implementing features.

## Speckit Workflow

The development workflow follows a strict sequential pipeline invoked through slash commands in Copilot Chat:

1. `/speckit.constitution` — Define project-wide principles and governance rules (stored in `.specify/memory/constitution.md`)
2. `/speckit.specify <description>` — Create a feature spec in `specs/NNN-feature-name/spec.md`
3. `/speckit.clarify` — Refine spec requirements interactively
4. `/speckit.plan` — Generate `plan.md`, `research.md`, `data-model.md`, and contract files in the feature directory
5. `/speckit.tasks` — Generate `tasks.md` with dependency-ordered implementation tasks
6. `/speckit.implement` — Execute implementation based on `tasks.md`
7. `/speckit.analyze` — Consistency check across artifacts
8. `/speckit.checklist` — Generate quality checklists
9. `/speckit.taskstoissues` — Sync tasks to GitHub Issues

Git extension commands (run automatically as hooks, or manually):
- `/speckit.git.initialize` — Init git repo
- `/speckit.git.feature` — Create a feature branch
- `/speckit.git.commit` — Auto-commit current state
- `/speckit.git.remote` — Configure remote
- `/speckit.git.validate` — Validate git state

## Repository Structure

```
.github/
  agents/         # Agent definition files (*.agent.md) — one per speckit command
  prompts/        # Prompt files (*.prompt.md) — one per speckit command
.specify/
  memory/
    constitution.md     # Project constitution (fill in before specifying features)
  feature.json          # Tracks the currently active feature directory
  extensions.yml        # Hook configuration — git hooks fire before/after each command
  extensions/git/       # Git workflow extension (branching, commits)
  templates/            # Spec, plan, tasks, checklist templates used by commands
  scripts/bash/         # Bash scripts (check-prerequisites.sh, update-agent-context.sh, etc.)
  integrations/copilot/ # Copilot-specific context update script
specs/                  # Created by /speckit.specify — one subdirectory per feature
  NNN-feature-name/
    spec.md
    plan.md
    research.md
    data-model.md
    tasks.md
    contracts/
    checklists/
```

## Key Conventions

- **Feature directories** are named `NNN-feature-name` with sequential 3-digit prefixes (e.g., `001-user-auth`). The prefix is determined by scanning existing `specs/` directories.
- **Active feature** is tracked in `.specify/feature.json` as `{ "feature_directory": "specs/NNN-name" }`. Downstream commands (`/speckit.plan`, `/speckit.tasks`, `/speckit.implement`) rely on this file to find the current feature.
- **Shell scripts** use bash (not PowerShell). The `init-options.json` sets `"script": "sh"`.
- **Git hooks** in `extensions.yml` fire automatically around each speckit command. Most are optional (prompt the user); `before_specify` (create feature branch) and `before_constitution` (init repo) are mandatory.
- **Specs are technology-agnostic**: `spec.md` describes *what* and *why* (user stories, acceptance criteria, success metrics) — never *how*. Implementation details go in `plan.md`.
- **Constitution must be filled before specifying**: The template in `.specify/memory/constitution.md` contains `[PLACEHOLDER]` tokens that must be replaced before running `/speckit.specify`.
- **check-prerequisites.sh** is run by agents at startup to resolve `FEATURE_DIR` and `AVAILABLE_DOCS`. It reads `.specify/feature.json` and validates that required artifacts exist before proceeding.

## Copilot Chat Setup

The `.vscode/settings.json` pre-enables these prompt recommendations in Copilot Chat:
- `speckit.constitution`, `speckit.specify`, `speckit.plan`, `speckit.tasks`, `speckit.implement`

Scripts in `.specify/scripts/bash/` and `.specify/scripts/powershell/` are auto-approved for terminal execution by Copilot.

## Agent and Prompt Files

Each speckit command has two files:
- `.github/agents/speckit.<command>.agent.md` — Full agent specification with pre/post hook logic
- `.github/prompts/speckit.<command>.prompt.md` — Shortened prompt version

When invoking a command, the agent files are the authoritative definition. They follow a consistent structure: user input → pre-execution hook check → outline (numbered steps) → post-execution hook check.

## Active Technologies
- HTML5, CSS3, Vanilla JavaScript (ES6+) — no transpilation + None (zero external runtime dependencies by constitution) (001-welcome-page)
- N/A — stateless by constitution (001-welcome-page)
- CSS3 (custom properties, `clamp()`, `@font-face`), Vanilla JS (none for design system itself) + None at runtime — fonts embedded at build time via `build.sh` (003-home-screen)

## Recent Changes
- 001-welcome-page: Added HTML5, CSS3, Vanilla JavaScript (ES6+) — no transpilation + None (zero external runtime dependencies by constitution)
