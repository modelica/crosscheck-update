#!/bin/sh

# Go into the data directory and update all repositories.  Then,
# process every repository and generate the data files
cd data
node update.js
process_repo vendors/* --output output

# Now work on building the site
cd site

# Revert any previous changes and pull most recent
git reset --hard origin/dynamic
git pull origin dynamic

# Now, copy the data files to to the site directory
cp ../output/*.json _data

# Fetch the latest copies of any dependencies
bundle install --path _vendor/bundle
bundle exec jekyll b

# If we have AWS credentials, attempt to put the new site contents in the
# specified bucket
[ $AWS_ACCESS_KEY!="" ] && [ $AWS_SECRET_KEY!="" ] && [ $AWS_BUCKET!="" ] && s3cmd -c ../data/s3.cfg put --recursive --acl-public _site/* s3://$AWS_BUCKET && s3cmd modify -m text/css s3://$(S3BUCKET)/css/*.css