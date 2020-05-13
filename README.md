# Autopsy

Dockerfile for building a __working__ version of Autopsy for Linux.
Unfotunately, their guidance for installing sucks and misses a lot of problems.
This dockerfile successfully builds and runs as of writing.

## Run
Note: The `xhost +` command is in the documentation for convienience. It is a security risk (https://laurentschneider.com/wordpress/2007/03/xhost-is-a-huge-security-hole.html). If you have concerns about your X security, please using xauth instead.

## Using Docker

[source](https://github.com/bannsec/autopsy_docker/issues/1)

```
$ xhost +
$ docker run \
            -d \
            -it \
            --shm-size 2G \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v $(pwd)/case/:/root/case \
            -e DISPLAY=$DISPLAY \
            -e JAVA_TOOL_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
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
