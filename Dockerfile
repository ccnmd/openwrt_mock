FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    gawk wget git-core git diffutils unzip clang zlib1g-dev build-essential \
    libncurses5-dev g++ gcc pkg-config libssl-dev xz-utils subversion \
    libelf-dev python3 python3-distutils python3-setuptools swig \
    libacl1-dev libattr1-dev \
    gettext libtool automake autoconf \
    file bison flex nano rsync \
    && rm -rf /var/lib/apt/list/*
    
ENV FORCE_UNSAFE_CONFIGURE=1

WORKDIR /build

RUN git clone https://git.openwrt.org/openwrt/openwrt.git

WORKDIR /

CMD ["/bin/bash"]

