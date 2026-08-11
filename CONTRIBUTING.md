# Contributing | 贡献指南

欢迎通过 Issue 或 Pull Request 提交改进。每个角色提示词必须保持单文件独立运行；新增规则应对应一个明确失败模式，并提供最小公开证据或合成示例。

Issues and pull requests are welcome. Every role prompt must remain runnable as a standalone file. A new rule should address a specific failure mode and include the smallest public evidence or synthetic example.

## 提交前 | Before submitting

1. 运行 `bash scripts/validate.sh`。
2. 确认 Markdown 代码围栏闭合、链接有效。
3. 不提交真实客户名、内部项目名、私有仓库地址、账号、邮箱、任务 ID、生产日志、提交 SHA、访问令牌或其他凭据。
4. 如果案例来自真实工作，只保留可公开的通用流程；无法证明已公开授权时，改写为合成示例并明确标注。
5. 不把静态检查、Mock 或本地测试写成生产验收通过。

1. Run `bash scripts/validate.sh`.
2. Confirm that Markdown fences are balanced and links are valid.
3. Do not submit real customer names, internal project names, private repository URLs, accounts, email addresses, task IDs, production logs, commit SHAs, access tokens, or other credentials.
4. If a case originates from real work, retain only the generic workflow that is safe to publish. When public authorization cannot be proven, rewrite it as a synthetic example and label it clearly.
5. Do not describe static checks, mocks, or local tests as passed production acceptance.

## 变更边界 | Change boundaries

- 角色行为变更：同步检查五个角色之间的结果字段、失败路由和 SHA 交接。
- 文档变更：中英文表达应保持语义一致。
- 示例和评估：必须区分合成数据、静态检查和真实运行证据。

- Role-behavior changes: recheck result fields, failure routing, and SHA handoffs across all five roles.
- Documentation changes: keep the Chinese and English meaning aligned.
- Examples and evaluations: distinguish synthetic data, static checks, and real execution evidence.
