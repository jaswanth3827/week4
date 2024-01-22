# Iterate through remote branches
for branch in $(git branch -r | grep 'origin/' | sed 's/origin\///'); do
    # List all files greater than 50MB
    git rev-list --objects --all | git cat-file --batch-check='%(objectsize) %(rest)' | awk -v branch="$branch" '$1 > 50000000 {print $1, branch, $2}' | while read -r size branch file; do
        # Check if the file exists in the branch
        if git ls-tree -r "$branch" "$file" >/dev/null 2>&1; then
            echo "$size $branch $file"
        fi
    done
done
