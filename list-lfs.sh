# List all files greater than 50MB in all remote branches
for branch in $(git branch -r | grep 'origin/' | sed 's/origin\///'); do
    git ls-tree -r --name-only "$branch" \
    | while read -r file; do
        size=$(git cat-file -s "$branch:$file")
        if [ "$size" -gt 50000000 ]; then
            echo "$size $branch $file"
        fi
    done
done
