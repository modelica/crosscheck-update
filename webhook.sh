#!/bin/sh

## This script does all the initial work but holds off on running build until
## a webhook is invoked

/home/builder/init.sh

webhook -verbose -hooks=/etc/webhooks/hooks.json
