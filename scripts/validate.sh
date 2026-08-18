#!/usr/bin/env bash
set -euo pipefail

role_files=(
  "01-自主任务调度者.md"
  "02-实施计划编写者.md"
  "03-计划评估者.md"
  "04-开发人员.md"
  "05-代码与功能验收者.md"
)

documentation_files=(
  "README.md"
  "docs/zh-CN/EXAMPLES.md"
  "docs/zh-CN/EVALUATION.md"
  "docs/zh-CN/CONTRIBUTING.md"
  "docs/zh-CN/CHANGELOG.md"
  "docs/en/README.md"
  "docs/en/EXAMPLES.md"
  "docs/en/EVALUATION.md"
  "docs/en/CONTRIBUTING.md"
  "docs/en/CHANGELOG.md"
)

for file in "${role_files[@]}"; do
  test -f "$file"
  grep -q 'role_result' "$file"
  grep -q 'failure_classification' "$file"
  grep -q 'FAST' "$file"
  grep -q 'STANDARD' "$file"
  grep -q 'FULL' "$file"
done

for file in "${documentation_files[@]}"; do
  test -f "$file"
done

grep -q 'identity_contract_matrix' "02-实施计划编写者.md"
grep -q 'identity_contract_matrix' "03-计划评估者.md"
grep -q 'plan_deviation' "04-开发人员.md"
grep -q 'CANDIDATE' "05-代码与功能验收者.md"
grep -q 'INTEGRATION' "05-代码与功能验收者.md"
grep -q 'manual_verification_pending' "05-代码与功能验收者.md"
grep -q 'success-contradiction' "01-自主任务调度者.md"
grep -q '验收交接预检' "01-自主任务调度者.md"
grep -q 'required_capabilities' "02-实施计划编写者.md"
grep -q 'verification_manifest' "03-计划评估者.md"
grep -q 'PASS/FAIL/NOT_RUN' "04-开发人员.md"
grep -q '七个非空字段' "04-开发人员.md"
grep -q '有界静态检查' "05-代码与功能验收者.md"
grep -q '七个非空字段' "05-代码与功能验收者.md"

while IFS= read -r file; do
  fences=$(grep -c '^```' "$file" || true)
  if (( fences % 2 != 0 )); then
    echo "Unbalanced Markdown fences: $file" >&2
    exit 1
  fi
done < <(find . -type f -name '*.md' -not -path './.git/*' -print)

bash scripts/audit-privacy.sh

echo 'Public artifact validation passed.'
