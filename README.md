# Agent Role Prompts

一组面向 Multica 和 Codex 类编码 Agent 的独立角色提示词，用于把软件任务组织成可追踪、可验收、可安全集成的自动化开发流程。

A collection of standalone role prompts for Multica and Codex-style coding agents. The prompts turn software tasks into a traceable, verifiable, and safely integrable maintenance workflow.

[公开示例 / Public examples](examples/README.md) · [协议评估 / Protocol evaluation](EVALUATION.md) · [贡献指南 / Contributing](CONTRIBUTING.md) · [变更记录 / Changelog](CHANGELOG.md)

> 本项目是独立社区项目，不代表 OpenAI、Codex 或 Multica 的官方实现。
>
> This is an independent community project and is not an official implementation of OpenAI, Codex, or Multica.

## 项目解决的问题 | What it solves

AI 可以生成代码，但开源项目维护还需要明确的任务边界、计划评审、提交交接、失败路由和独立验收。本项目把这些责任拆成五个可独立配置的角色，减少“代码生成成功但任务没有安全收口”的情况。

AI can generate code, but open-source maintenance also needs clear scope, plan review, commit handoffs, failure routing, and independent acceptance. This project separates those responsibilities into five independently configurable roles so that a successful code generation run does not get mistaken for a safely completed task.

## 当前内容 | What's included

- 5 个完整、独立的 Markdown 角色提示词。
- `FAST`、`STANDARD`、`FULL` 三种验证级别。
- 远程分支、不可变提交 SHA 和候选提交到集成提交的交接规则。
- 计划、实现、环境、外部授权和集成失败的分类路由。
- 对扫码、MFA、CAPTCHA、真实账号和生产权限等人工边界的明确标记。
- 无运行时依赖；提示词文件可直接复制到支持独立 Agent 指令的工具中。

- Five complete, standalone Markdown role prompts.
- Three verification profiles: `FAST`, `STANDARD`, and `FULL`.
- Handoff rules for remote branches, immutable commit SHAs, and candidate-to-integration verification.
- Failure routing for plan, implementation, environment, external authorization, and integration failures.
- Explicit boundaries for QR login, MFA, CAPTCHA, real accounts, and production permissions.
- No runtime dependencies; copy a prompt into any tool that supports independent agent instructions.

## 角色 | Roles

| 文件 | 中文职责 | English responsibility |
| --- | --- | --- |
| [01-自主任务调度者.md](01-自主任务调度者.md) | 冻结任务契约、拆分工作、调度角色、集成结果并安全收尾 | Freeze the task contract, split work, dispatch roles, integrate results, and close safely |
| [02-实施计划编写者.md](02-实施计划编写者.md) | 编写或修订可直接执行的最小实施计划 | Write or revise the smallest directly executable implementation plan |
| [03-计划评估者.md](03-计划评估者.md) | 独立检查计划是否真实、完整、最小且可执行 | Independently verify that a plan is real, complete, minimal, and executable |
| [04-开发人员.md](04-开发人员.md) | 按批准计划完成实现、自测、提交和远程交接 | Implement the approved unit, self-test it, commit it, and hand it off remotely |
| [05-代码与功能验收者.md](05-代码与功能验收者.md) | 基于当前提交和本轮证据执行代码与功能验收 | Accept or reject the current commit using current-run code and functional evidence |

## 执行链 | Workflow

```text
自主任务调度者 / Scheduler
  → 实施计划编写者 / Plan Writer
  → 计划评估者 / Plan Reviewer
  → 开发人员 / Developer
  → 代码与功能验收者 / Acceptance
  → 调度者集成与收尾 / Integration and closure
```

### 验证级别 | Verification profiles

- `FAST`：仅局部文案、单个图标、颜色或间距等纯展示修改。
- `STANDARD`：普通组件、页面、表单、状态、API 调用和业务逻辑。
- `FULL`：认证、权限、迁移、安全、公共契约或核心跨模块流程。

- `FAST`: local copy, a single icon, color, spacing, or other display-only changes.
- `STANDARD`: normal components, pages, forms, state, API calls, and business logic.
- `FULL`: authentication, permissions, migrations, security, public contracts, or core cross-module flows.

## 使用 | Usage

1. 将对应 Markdown 文件全文配置为一个独立 Agent 的系统提示词或角色指令。
2. 为角色提供文件中声明的 Issue、仓库、分支、提交 SHA 和平台能力。
3. 由“自主任务调度者”作为唯一入口启动任务。
4. 只把当前提交、本轮测试和直接运行证据作为验收依据。

1. Configure one Markdown file as the system prompt or role instruction for one independent agent.
2. Provide the Issue, repository, branch, commit SHA, and platform capabilities required by that file.
3. Start each task through the Scheduler role.
4. Use only the current commit, current-run tests, and direct execution evidence for acceptance.

## 首次使用前配置项目资源 | Configure the project resource first

当前角色组依赖项目的 `github_repo.resource_ref` 获取仓库和集成分支。不要只配置本机目录或 `default_branch_hint`。

The role group uses the project's `github_repo.resource_ref` for the repository and integration branch. Do not configure only a local directory or `default_branch_hint`.

```bash
# 1. 查看并切换到目标团队工作区 / List and switch to the target workspace
multica workspace list --output table
multica workspace switch <workspace-id-or-slug>

# 2. 找到目标项目 / Find the target project
multica project list --output table --full-id

# 3. 查看项目资源 / Inspect project resources
multica project resource list <project-id> --output json
```

已有 `github_repo` 资源时，补齐明确的集成分支：

If a `github_repo` resource already exists, set an explicit integration ref:

```bash
multica project resource update <project-id> <resource-id> \
  --ref <integration-ref> \
  --output json
```

没有资源时新增：

If it does not exist, add it:

```bash
multica project resource add <project-id> \
  --type github_repo \
  --url <repository-url> \
  --ref <integration-ref> \
  --output json
```

确认返回内容包含：

Confirm that the response contains:

```json
{
  "resource_type": "github_repo",
  "resource_ref": {
    "url": "<repository-url>",
    "ref": "<integration-ref>"
  }
}
```

## 安全与证据边界 | Safety and evidence boundaries

- 不把历史报告、Mock、提交信息或单次声明当作本轮验收证据。
- 不把本地提交、健康检查或代码层测试表述为已部署或已完成真实生产验收。
- 真人扫码、MFA、CAPTCHA、真实账号和生产权限缺失时，保留检查点并明确标记外部阻塞。
- 发现同一根因时优先在共享入口修复一次，而不是在每个调用方重复加保护。

- Do not treat historical reports, mocks, commit messages, or one-off claims as current acceptance evidence.
- Do not describe a local commit, health check, or code-level test as deployed or production-accepted.
- When QR login, MFA, CAPTCHA, real accounts, or production permissions are unavailable, preserve a checkpoint and mark the external block explicitly.
- When the same root cause is shared, fix the shared entry point once instead of adding repeated guards to every caller.

公开示例全部使用合成数据并明确标注。仓库的自动检查会拦截常见密钥、邮箱和本机绝对路径模式：

All public examples use explicitly labeled synthetic data. The automated check rejects common secret, email, and local absolute-path patterns:

```bash
bash scripts/validate.sh
```

当前公开评估包含 6 个合成场景，每个验证级别 2 个。其 `PASS` 只表示静态协议覆盖，不表示模型已执行、生产已部署或外部用户已采用。详情见 [EVALUATION.md](EVALUATION.md)。

The current public evaluation contains six synthetic scenarios, two per verification profile. `PASS` indicates static protocol coverage only; it does not claim model execution, production deployment, or external adoption. See [EVALUATION.md](EVALUATION.md).

## 贡献 | Contributing

欢迎提交 Issue 或 Pull Request。角色提示词必须保持单文件可运行，不应引入对隐藏公共文件的依赖；新增规则应说明它解决的失败模式，并附最小可复现证据或合成示例。提交前请遵循 [CONTRIBUTING.md](CONTRIBUTING.md) 的隐私检查。

Issues and pull requests are welcome. Each role prompt must remain runnable as a standalone file and must not depend on a hidden shared file. New rules should identify the failure mode they address and include the smallest reproducible evidence or synthetic example. Follow the privacy checks in [CONTRIBUTING.md](CONTRIBUTING.md) before submitting.

## 许可证 | License

本项目采用 [MIT License](LICENSE)。

This project is released under the [MIT License](LICENSE).
