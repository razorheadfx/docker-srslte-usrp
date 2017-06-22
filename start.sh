#!/bin/bash
docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD/conf:/conf srs bash
