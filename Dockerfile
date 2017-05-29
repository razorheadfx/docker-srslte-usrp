#installs all dependencies and builds srsLTE and srsUE

#the executable for ue can be found in /srs
#the source code and build directories can be found in /git
#run with docker run -i -t --privileged -v /dev/bus/usb:/dev/bus/usb <image> bash

FROM ubuntu:16.04
MAINTAINER razorheadfx <razorhead.effect@gmail.com>


RUN echo "Installing basics"
RUN apt-get update
RUN apt-get install -y gcc git make cmake build-essential software-properties-common
#software properties common is required for add-apt-repository

RUN echo "Adding repos"
RUN add-apt-repository -y ppa:ettusresearch/uhd

RUN echo "Installing deps"
RUN apt-get update
RUN apt-get install -y libboost-all-dev
#warning: pulled libboost-all-dev because libboost(-dev) alone left cmake unable to find boost when building the makefiles for srsUE
#ursp drivers
RUN apt-get install -y libuhd-dev uhd-host libuhd003
RUN python /usr/lib/uhd/utils/uhd_images_downloader.py

#srsLTE: volk 
RUN apt-get install -y libvolk1-bin libvolk1-dev
#srsLTE: libfftw 
RUN apt-get install -y libfftw3-bin libfftw3-dev
#srsUE: mbedtls
RUN apt-get install -y libmbedtls-dev

#make build dirs
RUN mkdir git
WORKDIR git
RUN git clone https://github.com/srsLTE/srsUE.git
RUN mkdir srsUE/build
RUN git clone https://github.com/srsLTE/srsLTE.git
RUN mkdir srsLTE/build

RUN echo "Building srsLTE"
WORKDIR /git/srsLTE/build
RUN cmake ../
RUN make install

RUN echo "Building srsUE"
WORKDIR /git/srsUE/build
RUN cmake ../
RUN make

RUN echo "Setting up env"
RUN mkdir /srs
WORKDIR srs
RUN ln -s -T /git/srsUE/build/ue/src/ue ue




