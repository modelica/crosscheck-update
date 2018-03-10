#!/bin/sh

## This script is used to generate the FMI web site in a single pass.  This
## means doing all the initialization works and then the actual build

# First, do the setup part then do the build part
sh init.sh

# Then, do the build part (the part that would normally get called when
# the webhook is triggered).
sh build.sh