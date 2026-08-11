#!/usr/bin/env bash
set -euo pipefail

role_files=(
  "01-自主任务调度者.md"
  "02-实施计划编写者.md"
  "03-计划评估者.md"
  "04-开发人员.md"
  "05-代码与功能验收者.md"
)

for file in "${role_files[@]}"; do
  test -f "$file"
  grep -q 'role_result' "$file"
  grep -q 'failure_classification' "$file"
  grep -q 'FAST' "$file"
  grep -q 'STANDARD' "$file"
  grep -q 'FULL' "$file"
done

grep -q 'identity_contract_matrix' "02-实施计划编写者.md"
grep -q 'identity_contract_matrix' "03-计划评估者.md"
grep -q 'plan_deviation' "04-开发人员.md"
grep -q 'CANDIDATE' "05-代码与功能验收者.md"
grep -q 'INTEGRATION' "05-代码与功能验收者.md"
grep -q 'manual_verification_pending' "05-代码与功能验收者.md"

while IFS= read -r file; do
  fences=$(grep -c '^```' "$file" || true)
  if (( fences % 2 != 0 )); then
    echo "Unbalanced Markdown fences: $file" >&2
    exit 1
  fi
done < <(find . -type f -name '*.md' -not -path './.git/*' -print)

privacy_pattern='(/Users/|/home/[A-Za-z0-9._-]+/|[A-Za-z]:\\Users\\|sk-[A-Za-z0-9_-]{10,}|gh[pousr]_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|-----BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY-----|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,})'

if find . -type f \( -name '*.md' -o -name '*.yml' -o -name '*.yaml' \) -not -path './.git/*' -print0 \
  | xargs -0 grep -nEI "$privacy_pattern"; then
  echo 'Potential private data found in public artifacts.' >&2
  exit 1
fi

echo 'Public artifact validation passed.'
