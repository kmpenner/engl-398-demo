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

# 4. Delete demo feature branches locally and remotely if present
for br in feature/french-entities feature/date-audit; do
    if git show-ref --verify --quiet "refs/heads/$br"; then
        echo "Deleting local $br branch..."
        git branch -D "$br"
    fi
    if git ls-remote --exit-code --heads origin "$br" >/dev/null 2>&1; then
        echo "Deleting remote $br branch on GitHub..."
        git push origin --delete "$br" 2>/dev/null || true
    fi
done

# 5. Verify XML syntax gate
echo "Verifying syntax gate..."
xmllint --noout witness.xml

echo "✓ Demonstration repository reset clean to main branch."
git status
