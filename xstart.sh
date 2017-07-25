#!/bin/bash

#a modified start file for using gui applications within the container with the gui being displayed on the host

#requires --privileged to create the tun interface
#requires access to the usb bus to get to the usrp
#requires --net=host to access the host network namespace to communicate with the mme and create the ue tunnel interface for the host to use

#the following enables using gui applications on the host:
#   export the host display variable
#   mount the current user's xauthority
#   use host namespace
#
#Troubleshooting:
#if it isn't possible to use --net=host for some reason,
#i.e. more elaborate setups - adding -v /tmp/.X11-unix:/tmp/.X11-unix
#exports the necessary domain socket
docker run -it --rm --privileged --net=host \
-v /dev/bus/usb:/dev/bus/usb \
-v $PWD/conf:/conf \
-e DISPLAY \
-v $HOME/.Xauthority:/root/.Xauthority \
srs bash
