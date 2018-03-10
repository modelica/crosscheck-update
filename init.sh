#!/bin/sh

## This script is responsible for all "start up" tasks.  This mainly means grabbing
## baseline copies of all repositories.

# Update Git settings so we don't grab unnecessarily files
cp data/.gitconfig ~/.gitconfig

git clone https://github.com/modelica/fmi-standard.org.git data/site

# Update the repositories to the latest versions.  This takes care of
# downloading an initial version of all vendor repositories.  These
# will be updated on each build, but this gets the overhead of the
# initial download out of the way
cd data
node clone.js

# Now go into the directory for the web site
cd site

# Grab the dynamic branch (for now)
git reset --hard origin/dynamic
git checkout dynamic

# An initial install of gems needed to build site
bundle install --path _vendor/bundle
