# goscratchello

Build container image from scratch for web app.

Build image:

    ./docker-build.sh

Run image:

    ./docker-run.sh

Tag image:

    docker tag udhos/web-scratch udhos/web-scratch:0.8.2

Push to registry:

    docker login
    docker push udhos/web-scratch:latest
    docker push udhos/web-scratch:0.8.2

Find a generated container image as `udhos/web-scratch` here:

https://hub.docker.com/r/udhos/web-scratch
