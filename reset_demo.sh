#!/usr/bin/env bash
# Reset the demonstration repository to its pristine starting baseline
set -e

echo "=== Resetting RELS 398 Demonstration Repository ==="

# 1. Abort any active merge
if [ -f .git/MERGE_HEAD ]; then
    echo "Aborting active merge..."
    git merge --abort
fi

# 2. Switch to main branch
git checkout main

# 3. Clean untracked and modified files
git reset --hard HEAD
git clean -fd

# 4. Delete feature branch locally and remotely if present
if git show-ref --verify --quiet refs/heads/feature/date-audit; then
    echo "Deleting local feature/date-audit branch..."
    git branch -D feature/date-audit
fi

if git ls-remote --exit-code --heads origin feature/date-audit >/dev/null 2>&1; then
    echo "Deleting remote feature/date-audit branch on GitHub..."
    git push origin --delete feature/date-audit 2>/dev/null || true
fi

# 5. Verify XML syntax gate
echo "Verifying syntax gate..."
xmllint --noout witness.xml

echo "✓ Demonstration repository reset clean to main branch."
git status
