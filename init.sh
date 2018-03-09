#!/bin/sh

## This script is responsible for all "start up" tasks.  This mainly means grabbing
## baseline copies of all repositories.

# Update Git settings so we don't grab unnecessarily files
cp data/.gitconfig ~/.gitconfig

git clone https://github.com/modelica/fmi-standard.org.git site

# Update the repositories to the latest versions.  This takes care of
# downloading an initial version of all vendor repositories.  These
# will be updated on each build, but this gets the overhead of the
# initial download out of the way
cd data

npm run init
