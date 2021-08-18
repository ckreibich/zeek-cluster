FROM fedora:34 as base

RUN dnf update -y
RUN dnf install -y cmake gcc gcc-c++ git make openssl-devel python3 python3-devel swig

FROM base as builder

ARG branch=master
ARG broker_repo=https://github.com/zeek/broker
ARG zeek_client_repo=https://github.com/zeek/zeek-client
ARG confflags="--disable-docs --disable-tests"

RUN mkdir /build && cd /build && git clone ${broker_repo} && cd broker && \
    git submodule sync --recursive && \
    git submodule update --recursive --init -j $(nproc --all)

RUN cd /build/broker && ./configure ${confflags} && make -j $(nproc --all) && make install

RUN cd /build && git clone ${zeek_client_repo} && cd zeek-client && \
    git checkout ${branch} && cp zeek-client /usr/local/bin

FROM base
LABEL maintainer="Christian Kreibich <christian@corelight.com>"

COPY --from=builder /usr/local/bin/zeek-client /usr/local/bin/
COPY --from=builder /usr/local/lib64/* /usr/local/lib64/
COPY --from=builder /usr/lib/python3.9/site-packages/broker /usr/lib/python3.9/site-packages/broker
