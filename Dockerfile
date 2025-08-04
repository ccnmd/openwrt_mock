FROM ubuntu:22.04

RUN apt update && apt install -y build-essential clang flex bison g++ gawk gcc-multilib \
    g++-multilib gettext git libncurses-dev libssl-dev python3 python3-distutils \
    rsync unzip zlib1g-dev file wget xz-utils subversion nano \
    && rm -rf /var/lib/apt/lists/*

ENV FORCE_UNSAFE_CONFIGURE=1

WORKDIR /build

RUN git clone https://git.openwrt.org/openwrt/openwrt.git

WORKDIR /

CMD [ "/bin/bash" ]
