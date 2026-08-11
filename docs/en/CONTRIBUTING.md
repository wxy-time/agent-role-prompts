# Contributing

Issues and pull requests are welcome. Every role prompt must remain runnable as a standalone file. A new rule should address a specific failure mode and include the smallest public evidence or synthetic example.

## Before submitting

1. Run `bash scripts/validate.sh` and `bash scripts/audit-privacy.sh`.
2. Confirm that Markdown fences are balanced and links are valid.
3. Do not submit real customer names, internal project names, private repository URLs, accounts, email addresses, task IDs, production logs, commit SHAs, access tokens, or other credentials.
4. If a case originates from real work, retain only the generic workflow approved for publication. When public authorization cannot be proven, rewrite it as a synthetic example and label it clearly.
5. Do not describe static checks, mocks, or local tests as passed production acceptance.

Role-behavior changes must recheck result fields, failure routing, and SHA handoffs across all five roles. Examples and evaluations must distinguish synthetic data, static checks, and real execution evidence.
