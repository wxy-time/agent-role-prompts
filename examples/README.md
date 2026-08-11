# Public Reference Scenarios | 公开参考场景

这些场景是为演示角色协议而编写的合成示例，不来自真实客户、私有仓库或生产日志，也不构成外部采用证明。

These are synthetic scenarios written to demonstrate the role protocol. They do not come from real customers, private repositories, or production logs, and they are not evidence of external adoption.

## 1. FAST：局部文案 | Local copy change

**需求 | Request**

将一个设置弹窗中的按钮文案从“保存”改为“保存更改”，不修改组件行为、API、数据结构或全局主题。

Change one settings-dialog button label from “Save” to “Save changes” without changing component behavior, APIs, data structures, or the global theme.

**预期路由 | Expected route**

```text
Scheduler → Developer → Acceptance → Scheduler closure
```

**预期证据 | Expected evidence**

- `verification_profile=FAST`
- 仅修改局部展示文件。
- 运行相关格式检查或最小组件检查。
- 验收确认没有业务逻辑、公共默认值或全局样式变更。

- `verification_profile=FAST`
- Only the local presentation file changes.
- Run the relevant formatter or smallest component check.
- Acceptance confirms that business logic, public defaults, and global styles did not change.

## 2. STANDARD：分页重复项 | Duplicate pagination results

**需求 | Request**

修复列表在重复游标响应下出现重复记录的问题；API 契约和数据库结构保持不变。

Fix duplicate list items produced by a repeated cursor response while keeping the API contract and database schema unchanged.

**预期路由 | Expected route**

```text
Scheduler → Plan Writer → Plan Reviewer → Developer → Acceptance → Scheduler closure
```

**预期证据 | Expected evidence**

- `verification_profile=STANDARD`
- 计划定位共享分页合并入口，不在每个页面重复加保护。
- 测试覆盖正常分页、重复游标和空页。
- 候选 SHA 与验收 SHA 完全一致。

- `verification_profile=STANDARD`
- The plan targets the shared pagination merge point instead of guarding every page separately.
- Tests cover normal pagination, a repeated cursor, and an empty page.
- The candidate SHA exactly matches the accepted SHA.

## 3. FULL：跨租户访问边界 | Cross-tenant access boundary

**需求 | Request**

阻止已登录用户读取另一个租户的资源，同时保持资源所有者的正常访问。

Prevent an authenticated user from reading another tenant's resource while preserving normal access for the resource owner.

**预期路由 | Expected route**

```text
Scheduler → Plan Writer → Plan Reviewer → Developer → Acceptance → Scheduler closure
```

**预期证据 | Expected evidence**

- `verification_profile=FULL`
- 计划记录身份、owner ID 来源和 tenant 约束。
- 验证所有者访问、跨租户拒绝和共享入口的绕过路径。
- 真实账号、MFA 或生产权限不可用时，只标记外部验证未执行，不伪造通过。

- `verification_profile=FULL`
- The plan records identities, the owner-ID source, and tenant constraints.
- Verification covers owner access, cross-tenant denial, and bypass paths through shared entry points.
- If real accounts, MFA, or production permissions are unavailable, external verification is marked as not run rather than fabricated as passed.

## Privacy rule | 隐私规则

公开示例只能使用通用业务名、占位符和合成数据。禁止提交真实客户名、内部项目名、私人仓库 URL、账号、邮箱、访问令牌、任务 ID、生产日志或可回溯到私有系统的提交 SHA。

Public examples may use only generic domain names, placeholders, and synthetic data. Do not commit real customer names, internal project names, private repository URLs, accounts, email addresses, access tokens, task IDs, production logs, or commit SHAs traceable to private systems.
