# Protocol Evaluation

This evaluation checks whether the role prompts contain the required protocol coverage. It does not measure real model success and does not claim production, human-flow, or external-adoption verification.

The dataset contains six synthetic scenarios, two per verification profile. It contains no real users, customers, repositories, issues, accounts, logs, or commit data.

| ID | Profile | Scenario | Required protocol | Static result |
| --- | --- | --- | --- | --- |
| EV-01 | FAST | Local button copy | Skip planning, minimal check, no logic expansion | PASS |
| EV-02 | FAST | Single icon spacing | Local presentation scope, upgrade on expansion, lightweight acceptance | PASS |
| EV-03 | STANDARD | API parameter validation | Plan and review, error-path tests, SHA handoff | PASS |
| EV-04 | STANDARD | Async state race | Shared root cause, targeted regression, independent acceptance | PASS |
| EV-05 | FULL | Cross-tenant authorization | Identity matrix, unauthorized-access denial, security acceptance | PASS |
| EV-06 | FULL | Database migration rollback | Migration risk, rollback evidence, post-integration recheck | PASS |

`PASS` means only that the corresponding static rules exist across the five role files and that the public artifacts pass structural and privacy checks. It does not mean an AI executed the scenario.

```bash
bash scripts/validate.sh
bash scripts/audit-privacy.sh
```

Not yet verified: external adoption and download volume, end-to-end completion in real public repositories, API cost and latency, human authorization, real accounts, deployment, and production acceptance.
