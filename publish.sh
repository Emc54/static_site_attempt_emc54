#!/bin/bash

#Script to be run after a commit and push in main to build and publish the site on gh-pages

mkdir -p compiled_site

# Build the site
cd ./jekyll_site
bundle exec jekyll build

# Copy it to the new folder
cp -a _site/. ../compiled_site/
cd ..

# Update the gitignore to the one from gh-pages
mv gitignore_gh_pages ./compiled_site/.gitignore
touch ./compiled_site/.nojekyll

# Stash all these changes to pop into the gh-pages branch
git add -f compiled_site/* 
git stash
git checkout gh-pages
git stash pop

#Extract the site from its folder
mv compiled_site/* ./
rm -r compiled_site

# Commit and push
git add .
git commit -m "Site Update - Automatically from main"
git push

# Switch back to main branch
git checkout main
