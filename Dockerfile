#installs all dependencies and builds srsLTE 2.0 >

#the executable for ue can be found in /srs
#the source code and build directories can be found in /git
#run with docker run -i -t --privileged -v /dev/bus/usb:/dev/bus/usb <image> bash
#use uhd_find_device to check if the container sees the USRP

FROM ubuntu:16.04
MAINTAINER razorheadfx <razorhead.effect@gmail.com>

RUN echo "Installing deps" \
 && apt-get update \
 && apt-get install -y software-properties-common \
 && add-apt-repository -y ppa:ettusresearch/uhd \
 && apt-get update \
 && echo "Basics" \
 && apt-get install -y \
        gcc \
        git \
        make \
        cmake \
        build-essential \
        pkg-config \
        nano \
        moreutils \
 && echo "Installing and downloading uhd software and fpga image" \
 && apt-get install -y \
        libuhd-dev \
        uhd-host \
        libuhd003 \
 && python /usr/lib/uhd/utils/uhd_images_downloader.py \
 && echo "Installing deps" \
 && apt-get install -y \
     libboost-all-dev \
     # warning: pulled libboost-all-dev because libboost(-dev) alone left cmake
     # unable to find boost when building the makefiles for srsUE
     libvolk1-bin \
     libvolk1-dev \
     libfftw3-bin \
     libfftw3-dev \
     libmbedtls-dev \
     libmbedtls10 \
     libsctp-dev \
     lksctp-tools \
     libconfig-dev \
     libconfig++-dev \
 && rm -rf /var/lib/apt/lists/*

#make build dirs
RUN echo "Building srsLTE" \
 && mkdir git \
 && cd git \
 && git clone https://github.com/srsLTE/srsLTE.git \
 && mkdir srsLTE/build \
 && echo "Building srsLTE" \
 && cd srsLTE/build \
 && cmake .. \
 && make install

WORKDIR /conf

# RUN echo "Setting up PATH"
ENV PATH "/git/srsLTE/build/lib/examples:$PATH"
ENV PATH "/git/srsLTE/build/srsenb/src:$PATH"
ENV PATH "/git/srsLTE/build/srsue/src:$PATH"
