# Autopsy

Dockerfile for building a __working__ version of Autopsy for Linux.
Unfotunately, their guidance for installing sucks and misses a lot of problems.
This dockerfile successfully builds and runs as of writing.

## Run

## Using Docker

[source](https://github.com/bannsec/autopsy_docker/issues/1)

```
$ docker run \
            -d \
            -it \
            --shm-size 2G \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v ./case/:/root/case
            -e DISPLAY=$DISPLAY \
            --network host \
            bannsec/autopsy
```

## Using Docker Compose

Just run:

```
$ xhost + && docker-compose up -d
```

## Loading an image file for a case

The volume mounted in the local folder `./case/` should be used to share disk
images and cases files, so put here your evidence and load it in the Autopsy
wizard.
