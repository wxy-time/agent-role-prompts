# Public Reference Scenarios

These synthetic scenarios demonstrate the role protocol. They do not come from real customers, private repositories, or production logs, and they are not evidence of external adoption.

## 1. FAST: Local copy change

Request: Change one settings-dialog button label from “Save” to “Save changes” without changing component behavior, APIs, data structures, or the global theme.

```text
Scheduler → Developer → Acceptance → Scheduler closure
```

Expected evidence: `verification_profile=FAST`, only the local presentation file changes, the smallest relevant check runs, and acceptance confirms that business logic and public defaults did not change.

## 2. STANDARD: Duplicate pagination results

Request: Fix duplicate list items produced by a repeated cursor response while keeping the API contract and database schema unchanged.

```text
Scheduler → Plan Writer → Plan Reviewer → Developer → Acceptance → Scheduler closure
```

Expected evidence: `verification_profile=STANDARD`, the shared pagination merge point is fixed, tests cover normal pagination/repeated cursors/empty pages, and the candidate SHA matches the accepted SHA.

## 3. FULL: Cross-tenant access boundary

Request: Prevent an authenticated user from reading another tenant's resource while preserving normal access for the resource owner.

```text
Scheduler → Plan Writer → Plan Reviewer → Developer → Acceptance → Scheduler closure
```

Expected evidence: `verification_profile=FULL`, identities and tenant constraints are recorded, and owner access and cross-tenant denial are verified. If real accounts, MFA, or production permissions are unavailable, external verification is marked as not run.

## Privacy rule

Public examples may use only generic domain names, placeholders, and synthetic data. Do not commit real customer names, internal project names, private repository URLs, accounts, email addresses, access tokens, task IDs, production logs, or commit SHAs traceable to private systems.
