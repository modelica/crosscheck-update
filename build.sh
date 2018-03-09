#!/bin/sh

# Go into the data directory and update all repositories.  Then,
# process every repository and generate the data files
cd data
node update.js
process_repo vendors/*

# Now work on building the site
cd site

# Revert any previous changes and pull most recent
git reset --hard origin/dynamic
git pull origin dynamic

# Now, copy the data files to to the site directory

# Now build the site
# bundle update pygments.rb nokogiri html-pipeline # This should be done once in
# the repo, right?

# Fetch the latest copies of any dependencies
bundle install --path _vendor/bundle
bundle exec jekyll b