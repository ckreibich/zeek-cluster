FROM fedora:34 as base

RUN dnf update -y
RUN dnf install -y bison cmake gcc gcc-c++ flex git libpcap-devel make openssl-devel python3 python3-devel swig zlib-devel

FROM base as builder

ARG branch=master
ARG repo=https://github.com/zeek/zeek
ARG confflags="--enable-zeek-client"

RUN mkdir /build && cd /build && git clone ${repo} && cd zeek && \
    git checkout ${branch} && \
    git submodule sync --recursive && \
    git submodule update --recursive --init -j $(nproc --all)

RUN cd /build/zeek && ./configure ${confflags} && make -j $(nproc --all) && make install

FROM base
LABEL maintainer="Christian Kreibich <christian@corelight.com>"

# zkg's Python dependencies have RPMs on Fedora
RUN dnf install -y python3-GitPython python3-semantic_version
# Additional tools
RUN dnf install -y bind-utils findutils procps-ng net-tools telnet

COPY --from=builder /usr/local/zeek /usr/local/zeek
RUN echo "export PATH=$PATH:/usr/local/zeek/bin" >/etc/profile.d/zeek.sh

RUN mkdir -p /var/log/zeek/mgmt
RUN mkdir -p /var/log/zeek/cluster

WORKDIR /var/log/zeek
