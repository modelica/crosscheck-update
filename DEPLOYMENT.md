## Running the Server

I deployed this on Digital Ocean with a pretty trivial set of commands:

```sh
$ docker-machine create --driver digitalocean --digitalocean-size s-1vcpu-1gb --digitalocean-access-token=$DO_TOKEN cross-check
$ eval $(docker-machine env cross-check)
$ docker run -d -p 80:9000 --restart always -e NETLIFY_TOKEN=... --name xc modelica/crosscheck-update
```

To see what is going on with the machine during builds, just run:

```sh
$ eval $(docker-machine env cross-check)
$ docker logs xc
```

To continuously monitor activity, do `docker logs -f xc` instead.

## Triggering Builds

Once a Docker image is running on a publically accessible machine, the only
thing required in order to trigger a build on a "push" to a vendor repository is
to add a "webhook" to that repository. The webhook configuration is under
"Settings". Just navigate to the "Webhooks" section and press the "Add webhook"
button. The only required step is to fill in the "Payload URL" field with a URL
of the form:

```
http://<IP ADDRESS OF SERVER>:9000/hooks/fmi-build
```
