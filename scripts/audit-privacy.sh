#!/usr/bin/env bash
set -euo pipefail

privacy_pattern='(/Users/|/home/[A-Za-z0-9._-]+/|[A-Za-z]:\\Users\\|sk-[A-Za-z0-9_-]{10,}|gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|-----BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY-----|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,})'
private_name_pattern='(bwnext|chunhon|蓝鲸|WS-[0-9]+|Desktop/)'

scan_current() {
  if find . -type f \( -name '*.md' -o -name '*.yml' -o -name '*.yaml' -o -name '*.json' -o -name '*.txt' \) \
    -not -path './.git/*' -print0 \
    | xargs -0 grep -IlE "$privacy_pattern|$private_name_pattern" >/dev/null; then
    echo 'Potential private data found in the current public tree.' >&2
    return 1
  fi
}

scan_filenames() {
  if git log --all --name-only --format= | grep -E "$private_name_pattern" >/dev/null; then
    echo 'Potential private identifier found in Git history filenames.' >&2
    return 1
  fi
}

scan_commit_emails() {
  while IFS= read -r email; do
    case "$email" in
      *@users.noreply.github.com) ;;
      *)
        echo 'Non-noreply commit email found in Git history.' >&2
        return 1
        ;;
    esac
  done < <(git log --all --format='%ae%n%ce' | sort -u)
}

scan_remotes() {
  if git remote -v | grep -E 'https://[^/@]+:[^/@]+@' >/dev/null; then
    echo 'Credential-bearing Git remote URL found.' >&2
    return 1
  fi
}

scan_history_content() {
  while IFS= read -r commit; do
    if git grep -IlE "$privacy_pattern|$private_name_pattern" "$commit" -- \
      '*.md' '*.yml' '*.yaml' '*.json' '*.txt' \
      ':(exclude)scripts/validate.sh' \
      ':(exclude)scripts/audit-privacy.sh' >/dev/null 2>&1; then
      echo 'Potential private data found in Git history content.' >&2
      return 1
    fi
  done < <(git rev-list --all)
}

scan_current
scan_filenames
scan_commit_emails
scan_remotes
scan_history_content

echo 'Full privacy audit passed.'
