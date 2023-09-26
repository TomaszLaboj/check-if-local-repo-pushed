1#!/bin/bash

# Path to the folder containing all git repos
repo_folder="/path/to/your/directory"

#list all subdirectories

repo_paths=($(find "$repo_folder" -mindepth 1 -maxdepth 1 -type d))

for repo_path in "${repo_paths[@]}"; do
	echo "Checking repo : $repo_path"
	cd "$repo_path" || continue

	# list all local branches
	local_branches=$(git branch | cut -c 3-)

	for branch in $local_branches; do
		#check if the branch exists on the remote
		if ! git ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1; then
		echo "Branch '$branch' not pushed to remote in $repo_path"

		fi
	done

	cd - >/dev/null
done
