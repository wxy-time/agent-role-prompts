# Agent Role Prompts

[简体中文](../zh-CN/README.md)

A collection of standalone role prompts for Multica and Codex-style coding agents. The prompts turn software tasks into a traceable, verifiable, and safely integrable maintenance workflow.

> This is an independent community project and is not an official implementation of OpenAI, Codex, or Multica.

[Public examples](EXAMPLES.md) · [Protocol evaluation](EVALUATION.md) · [Contributing](CONTRIBUTING.md) · [Changelog](CHANGELOG.md)

## What it solves

AI can generate code, but open-source maintenance also needs clear scope, plan review, commit handoffs, failure routing, and independent acceptance. This project separates those responsibilities into five independently configurable roles so that code generation is not mistaken for safe task completion.

## What's included

- Five complete, standalone Markdown role prompts.
- Three verification profiles: `FAST`, `STANDARD`, and `FULL`.
- Handoff rules for remote branches, immutable commit SHAs, and candidate-to-integration verification.
- Failure routing for plan, implementation, environment, external authorization, and integration failures.
- Explicit boundaries for QR login, MFA, CAPTCHA, real accounts, and production permissions.
- No runtime dependencies; each prompt can be copied into a tool that supports independent agent instructions.

## Roles

The executable prompt files currently use Chinese names and content.

| File | Responsibility |
| --- | --- |
| [01-自主任务调度者.md](../../01-自主任务调度者.md) | Freeze the task contract, split work, dispatch roles, integrate results, and close safely |
| [02-实施计划编写者.md](../../02-实施计划编写者.md) | Write or revise the smallest directly executable implementation plan |
| [03-计划评估者.md](../../03-计划评估者.md) | Independently verify that a plan is real, complete, minimal, and executable |
| [04-开发人员.md](../../04-开发人员.md) | Implement the approved unit, self-test it, commit it, and hand it off remotely |
| [05-代码与功能验收者.md](../../05-代码与功能验收者.md) | Accept or reject the current commit using current-run code and functional evidence |

## Workflow

```text
Scheduler
  → Plan Writer
  → Plan Reviewer
  → Developer
  → Acceptance
  → Integration and closure
```

## Verification profiles

- `FAST`: local copy, a single icon, color, spacing, or other display-only changes.
- `STANDARD`: normal components, pages, forms, state, API calls, and business logic.
- `FULL`: authentication, permissions, migrations, security, public contracts, or core cross-module flows.

## Usage

1. Configure one Markdown file as the system prompt or role instruction for one independent agent.
2. Provide the Issue, repository, branch, commit SHA, and platform capabilities required by that file.
3. Start each task through the Scheduler role.
4. Use only the current commit, current-run tests, and direct execution evidence for acceptance.

## Configure the project resource first

The role group uses the project's `github_repo.resource_ref` for the repository and integration branch. Do not configure only a local directory or `default_branch_hint`.

```bash
multica workspace list --output table
multica workspace switch <workspace-id-or-slug>
multica project list --output table --full-id
multica project resource list <project-id> --output json
```

Set an explicit integration ref when a `github_repo` resource exists:

```bash
multica project resource update <project-id> <resource-id> \
  --ref <integration-ref> \
  --output json
```

Add the resource when it does not exist:

```bash
multica project resource add <project-id> \
  --type github_repo \
  --url <repository-url> \
  --ref <integration-ref> \
  --output json
```

## Public evidence and privacy boundaries

- [Public examples](EXAMPLES.md) contains three synthetic scenarios that do not come from real customers or private projects.
- [Protocol evaluation](EVALUATION.md) contains six static checks, two per verification profile.
- `PASS` indicates static protocol coverage only; it does not claim AI execution, production deployment, or external adoption.
- Do not publish customer names, internal project names, private repositories, accounts, email addresses, task IDs, production logs, secrets, or private commit SHAs.

Run the public-artifact and full-history privacy checks:

```bash
bash scripts/validate.sh
bash scripts/audit-privacy.sh
```

## Contributing and license

Follow the [contribution guide](CONTRIBUTING.md) before submitting. This project is released under the [MIT License](../../LICENSE).
