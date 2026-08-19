# Changelog

## [0.2.1] - 2026-08-19

- Acceptance defaults to a single CANDIDATE round; integration merges are handled by scheduler-side mechanical checks (ancestry, target ref, conflict-region review, and integration-point combination build), with an extra INTEGRATION acceptance only for non-trivial merges.

## [0.2.0] - 2026-08-19

- Verification profiles are now graded by actual impact: FULL only when schema/migrations/RLS, public API contract structure, or auth/permission logic is actually modified; tasks reusing an existing isolation mechanism drop to STANDARD with interface-level isolation smoke checks only.
- Builds and regression runs are scoped to affected packages including their reverse-dependency closure; backend-only changes skip frontend builds, and a full repository-wide build runs once at the integration point.
- Frontend code-level tests are kept and executed diff-scoped instead of being removed.

## [0.1.1] - 2026-08-11

- Split Chinese and English documentation into separate paths.
- Added full Git-history and commit-metadata privacy auditing.
- Replaced the private commit email in repository history with a GitHub noreply identity.

## [0.1.0] - 2026-08-11

- Released five standalone role prompts and three verification profiles.
- Added the MIT License, public synthetic scenarios, static protocol evaluation, and public-artifact privacy checks.
