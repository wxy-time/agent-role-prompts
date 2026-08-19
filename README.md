# Agent Role Prompts

[English documentation](docs/en/README.md)

一组面向 Multica 和 Codex 类编码 Agent 的独立角色提示词，用于把软件任务组织成可追踪、可验收、可安全集成的自动化开发流程。

> 本项目是独立社区项目，不代表 OpenAI、Codex 或 Multica 的官方实现。

[公开示例](docs/zh-CN/EXAMPLES.md) · [协议评估](docs/zh-CN/EVALUATION.md) · [贡献指南](docs/zh-CN/CONTRIBUTING.md) · [变更记录](docs/zh-CN/CHANGELOG.md)

## 项目解决的问题

AI 可以生成代码，但开源维护还需要明确的任务边界、计划评审、提交交接、失败路由和独立验收。本项目把这些责任拆成五个可独立配置的角色，减少“代码生成成功但任务没有安全收口”的情况。

## 当前内容

- 5 个完整、独立的 Markdown 角色提示词。
- `FAST`、`STANDARD`、`FULL` 三种验证级别。
- 远程分支、不可变提交 SHA 和候选提交到集成提交的交接规则。
- 默认单轮独立验收：候选提交验收后由调度者做集成机械检查，仅非平凡合并按需补一次集成验收。
- 计划、实现、环境、外部授权和集成失败的分类路由。
- 对扫码、MFA、CAPTCHA、真实账号和生产权限等人工边界的明确标记。
- 无运行时依赖，可直接复制到支持独立 Agent 指令的工具中。

## 角色

| 文件 | 职责 |
| --- | --- |
| [01-自主任务调度者.md](01-自主任务调度者.md) | 冻结任务契约、拆分工作、调度角色、集成结果并安全收尾 |
| [02-实施计划编写者.md](02-实施计划编写者.md) | 编写或修订可直接执行的最小实施计划 |
| [03-计划评估者.md](03-计划评估者.md) | 独立检查计划是否真实、完整、最小且可执行 |
| [04-开发人员.md](04-开发人员.md) | 按批准计划完成实现、自测、提交和远程交接 |
| [05-代码与功能验收者.md](05-代码与功能验收者.md) | 基于当前提交和本轮证据执行代码与功能验收 |

## 执行链

```text
自主任务调度者
  → 实施计划编写者
  → 计划评估者
  → 开发人员
  → 代码与功能验收者
  → 调度者集成与收尾
```

## 验证级别

- `FAST`：局部文案、单个图标、颜色或间距等纯展示修改。
- `STANDARD`：普通组件、页面、表单、状态、API 调用和业务逻辑；复用既有隔离机制的改动只做接口级隔离冒烟。
- `FULL`：实际修改数据库 schema/迁移/RLS、公共 API 契约结构或认证/权限判断逻辑，或涉及资金、核心跨模块流程。

构建和回归按受影响包定向（含共享包的反向依赖闭包）；全仓全量构建只在集成点统一执行一次。

## 使用

1. 将对应 Markdown 文件全文配置为一个独立 Agent 的系统提示词或角色指令。
2. 为角色提供文件中声明的 Issue、仓库、分支、提交 SHA 和平台能力。
3. 由“自主任务调度者”作为唯一入口启动任务。
4. 只把当前提交、本轮测试和直接运行证据作为验收依据。

## 首次使用前配置项目资源

角色组依赖项目的 `github_repo.resource_ref` 获取仓库和集成分支，不要只配置本机目录或 `default_branch_hint`。

```bash
multica workspace list --output table
multica workspace switch <workspace-id-or-slug>
multica project list --output table --full-id
multica project resource list <project-id> --output json
```

已有 `github_repo` 资源时设置明确的集成引用：

```bash
multica project resource update <project-id> <resource-id> \
  --ref <integration-ref> \
  --output json
```

没有资源时新增：

```bash
multica project resource add <project-id> \
  --type github_repo \
  --url <repository-url> \
  --ref <integration-ref> \
  --output json
```

## 公开证据与隐私边界

- [公开示例](docs/zh-CN/EXAMPLES.md)包含 3 个合成场景，不来自真实客户或私有项目。
- [协议评估](docs/zh-CN/EVALUATION.md)包含 6 项静态检查，每个验证级别 2 项。
- `PASS` 只表示静态协议覆盖，不表示 AI 已实际执行、生产已部署或外部用户已采用。
- 不公开客户名、内部项目名、私有仓库、账号、邮箱、任务 ID、生产日志、密钥或私人提交 SHA。

运行公开制品和全历史隐私检查：

```bash
bash scripts/validate.sh
bash scripts/audit-privacy.sh
```

## 贡献与许可证

提交前请遵循[贡献指南](docs/zh-CN/CONTRIBUTING.md)。本项目采用 [MIT License](LICENSE)。
