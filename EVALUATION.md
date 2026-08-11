# Protocol Evaluation | 协议评估

## 评估范围 | Scope

本评估只检查仓库中的角色提示词是否覆盖关键协议，不评估任何模型的真实任务成功率，也不代表生产环境、真人操作或外部采用已经得到验证。

This evaluation checks whether the role prompts contain the required protocol coverage. It does not measure real model task success and does not claim production, human-flow, or external-adoption verification.

## 数据集 | Dataset

评估集包含 6 个合成场景，每个验证级别 2 个。场景不含真实用户、客户、仓库、Issue、账号、日志或提交信息。

The dataset contains six synthetic scenarios, two per verification profile. It contains no real users, customers, repositories, issues, accounts, logs, or commit data.

| ID | 级别 | 场景 | 必需协议 | 静态结果 |
| --- | --- | --- | --- | --- |
| EV-01 | FAST | 局部按钮文案 | 跳过计划阶段、最小检查、禁止逻辑越界 | PASS |
| EV-02 | FAST | 单个图标间距 | 局部展示范围、越界升级、轻量验收 | PASS |
| EV-03 | STANDARD | API 参数校验 | 计划与评审、异常路径测试、SHA 交接 | PASS |
| EV-04 | STANDARD | 异步状态竞争 | 共享根因、定向回归、独立验收 | PASS |
| EV-05 | FULL | 跨租户授权 | 身份矩阵、越权拒绝、安全验收 | PASS |
| EV-06 | FULL | 数据库迁移回滚 | 迁移风险、回滚证据、集成后复验 | PASS |

| ID | Profile | Scenario | Required protocol | Static result |
| --- | --- | --- | --- | --- |
| EV-01 | FAST | Local button copy | Skip planning, minimal check, no logic expansion | PASS |
| EV-02 | FAST | Single icon spacing | Local presentation scope, upgrade on expansion, lightweight acceptance | PASS |
| EV-03 | STANDARD | API parameter validation | Plan and review, error-path tests, SHA handoff | PASS |
| EV-04 | STANDARD | Async state race | Shared root cause, targeted regression, independent acceptance | PASS |
| EV-05 | FULL | Cross-tenant authorization | Identity matrix, unauthorized-access denial, security acceptance | PASS |
| EV-06 | FULL | Database migration rollback | Migration risk, rollback evidence, post-integration recheck | PASS |

## PASS 的含义 | Meaning of PASS

`PASS` 仅表示五个角色文件中可以找到对应的静态规则，并且公开制品通过 `scripts/validate.sh` 的结构和隐私检查。它不表示场景已由 AI 实际执行。

`PASS` means only that the corresponding static rules exist across the five role files and that the public artifacts pass the structural and privacy checks in `scripts/validate.sh`. It does not mean an AI actually executed the scenario.

## 可重复检查 | Reproduce

```bash
bash scripts/validate.sh
```

检查内容：

- 5 个角色文件均存在。
- 每个角色包含结果协议、失败分类和三种验证级别。
- Markdown 代码围栏成对闭合。
- 公开文档中未出现常见密钥、邮箱或本机绝对路径模式。

The check verifies:

- All five role files exist.
- Every role includes result protocol, failure classification, and all three verification profiles.
- Markdown code fences are balanced.
- Public documents contain no common secret, email, or local absolute-path patterns.

## 尚未验证 | Not yet verified

- 外部维护者采用数量和下载量。
- 真实公开仓库中的端到端完成率。
- API 成本、延迟和模型间对比。
- 真人授权、真实账号、部署和生产验收。

- External maintainer adoption and download volume.
- End-to-end completion rate in real public repositories.
- API cost, latency, and cross-model comparisons.
- Human authorization, real accounts, deployment, and production acceptance.
