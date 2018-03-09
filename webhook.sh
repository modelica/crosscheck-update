#!/bin/sh

## This script does all the initial work but holds off on running build until
## a webhook is invoked

/usr/build/init.sh

webhook -verbose -hooks=/etc/webhooks/hooks.json
