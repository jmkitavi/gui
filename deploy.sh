#!/bin/bash
echo "Deleting old publication"
 rm -rf public
 mkdir public
 git worktree prune
 rm -rf .git/worktrees/public/
 echo "Checking out gh-pages branch into public"
 git worktree add -B gh-pages public origin/gh-pages
 echo "Removing existing files"
 rm -rf public/*
 echo "Generating site"
 hugo
 echo "Updating gh-pages branch"
 cd public && git add --all && git commit -m "Initial Post"
# Push source and build repos.
git push origin gh-pages
# create new post
# hugo new posts/my-first-post.md
# start local server
# hugo server -D%