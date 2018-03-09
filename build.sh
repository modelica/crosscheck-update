#!/bin/sh

cd data
npm run build

cd site
git pull
jekyll build