#!/bin/sh

# Update Git settings so we don't grab unnecessarily files
cp data/.gitconfig ~/.gitconfig

# Update the repositories to the latest versions.  This takes care of
# downloading an initial version of all vendor repositories.  These
# will be updated on each build, but this gets the overhead of the
# initial download out of the way
cd data

npm run init

webhook -verbose -hooks=/etc/webhooks/hooks.json
