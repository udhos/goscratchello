# goscratchello

Build container image from scratch for web app.

Build image:

    ./build.sh

Run image:

    ./run.sh

Tag image:

    docker tag udhos/web-scratch udhos/web-scratch:0.4.2

Push to registry:

    docker login
    docker push udhos/web-scratch:latest

Find a generated container image as `udhos/web-scratch` here:

https://hub.docker.com/r/udhos/web-scratch
