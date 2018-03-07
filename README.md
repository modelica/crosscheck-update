# Cross-check Updating

This repository is used as part of the continuous integration (CI) processs used to update
FMI cross-check results. There is very little value in anybody else checking this
repository out since it's only real value is to be part of the CI process.

# Docker Image

The `Dockerfile` in this repository describes how to build the Docker image
associated with this repository. The Docker image is named
`modelica/crosscheck-update` and it is rebuilt automatically whenever there is a
push to this repository.

# Maintenance

The list of all vendor IDs is contained in the file `vendors.json`. This is the
main piece that might change over time.

The `start.sh` script initializes the server by downloading all vendor
repositories. The `build.sh` script is called whenever the webhook is called
(see below). Ultimately, the `process_repo` script from the
`@modelica/fmi-xc-scripts` module is called to do the processing.

# Webhooks

The `Dockerfile` configures a webhook server to be run when this image is
launched. The webhook server is listening on port 9000. Any `POST` operation
to `/hooks/fmi-build` on that port will trigger a rebuild. This webhook can be
trivially configured in a vendor's GitHub repository so that a `push` to that
repository triggers a rebuild.
