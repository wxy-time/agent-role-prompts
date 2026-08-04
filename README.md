# Agent Role Prompts

一组面向 Multica 的独立 AI 开发角色提示词，用于把一个业务任务组织成可追踪、可验收的自动化开发流程。

## 角色

| 文件 | 职责 |
| --- | --- |
| [01-自主任务调度者.md](01-自主任务调度者.md) | 冻结任务契约、拆分工作、调度角色、集成结果并安全收尾 |
| [02-实施计划编写者.md](02-实施计划编写者.md) | 编写或修订可由下游 AI 直接执行的最小实施计划 |
| [03-计划评估者.md](03-计划评估者.md) | 独立检查计划是否真实、完整、最小且可执行 |
| [04-开发人员.md](04-开发人员.md) | 按批准计划完成最小实现、自测、提交和远程交接 |
| [05-代码与功能验收者.md](05-代码与功能验收者.md) | 基于当前提交和真实证据执行代码与功能验收 |

每个角色文件都是完整、独立的提示词，不依赖公共协议或其他角色文件。

## 执行链

```text
自主任务调度者
  → 实施计划编写者
  → 计划评估者
  → 开发人员
  → 代码与功能验收者
  → 调度者集成与收尾
```

流程支持 `FAST`、`STANDARD`、`FULL` 三种验证级别，并通过远程分支、不可变提交 SHA、有限重试和明确的失败分类控制无人值守执行风险。

## 使用

1. 将对应 Markdown 文件全文配置为该角色的提示词。
2. 为角色提供文件中声明的 Issue、仓库、分支和平台能力。
3. 由自主任务调度者作为唯一入口启动任务。

## 首次使用前配置项目资源

当前角色组依赖项目的 `github_repo.resource_ref` 获取仓库和集成分支。请先在目标团队工作区配置资源；不要只配置本机目录或 `default_branch_hint`。

```bash
# 1. 查看并切换到目标团队工作区
multica workspace list --output table
multica workspace switch <workspace-id或slug>

# 2. 找到目标项目及 project-id
multica project list --output table --full-id

# 3. 查看项目资源及 resource-id
multica project resource list <project-id> --output json
```

已有 `github_repo` 资源时，补齐明确的集成分支：

```bash
multica project resource update <project-id> <resource-id> \
  --ref <integration-ref> \
  --output json
```

没有 `github_repo` 资源时，新增资源：

```bash
multica project resource add <project-id> \
  --type github_repo \
  --url <repository-url> \
  --ref <integration-ref> \
  --output json
```

最后重新查看资源，确认返回内容同时包含以下字段：

```json
{
  "resource_type": "github_repo",
  "resource_ref": {
    "url": "<repository-url>",
    "ref": "<integration-ref>"
  }
}
```

`ref` 可以是分支名或提交 SHA。按当前任务契约，`integration_ref` 只能来自父 Issue 明示值，或该 `github_repo` 的 `resource_ref.ref`；`default_branch_hint`、远程默认分支、本机当前分支都不能替代它。配置完成后再创建任务；若已存在的运行时仍提示缺少字段，刷新任务，必要时执行 `multica daemon restart`。
