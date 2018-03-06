# Cross-check Updating

This repository is used as part of the continuous integration (CI) processs used to update
FMI cross-check results. There is very little value in anybody else checking this
repository out since it's only real value is to be part of the CI process.

# Maintenance

The list of all vendor IDs is contained in the file `genmodules.js`. The build
process is triggered by running `npm run build`. This invokes the
`genmodules.js` file which generates a `.gitmodules` file that associates all
the named vendor repositories with this one. The `npm run build` script then
checks out all the vendor repositories as Git submodules. Finally, it runs
the `process_repo` script supplied by the `@modelica/fmi-xc-scripts` repository.

# Webhooks

This repository is linked to SemaphoreCI. So whenever there is a commit to this
repository, it will trigger a rebuild of everything. But we **also** want to
trigger a rebuild if any of the vendor repositories change. Fortunately,
SemaphoreCI provides a "webhook" that we can invoke to trigger rebuilding as well.
