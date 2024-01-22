# List all files greater than 50MB in all branches
git rev-list --objects --all | git cat-file --batch-check='%(objectsize) %(rest)' | awk '$1 > 50000000 {print $2}' | xargs -I {} git ls-tree -r --name-only HEAD {} 2>/dev/null
