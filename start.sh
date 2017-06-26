#!/bin/bash
#requires --privileged to create the tun interface
#requires access to the usb bus to get to the usb
#requires --net=host to access the host network namespace to communicate with the mme and the ue tunnel interface
docker run -it --rm --privileged --net=host -v /dev/bus/usb:/dev/bus/usb -v $PWD/conf:/conf srs bash
