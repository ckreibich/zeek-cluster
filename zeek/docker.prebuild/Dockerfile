FROM fedora:34 as prebuild

RUN dnf install -y bison ccache cmake gcc gcc-c++ make python3 flex git \
    libpcap-devel openssl-devel python3-devel swig zlib-devel

# Locations in our image
ENV ZEEK_DIR=/zeek
ENV ZEEK_SRC_DIR=$ZEEK_DIR/src
ENV ZEEK_TOOLS_DIR=$ZEEK_DIR/tools

RUN mkdir -p $ZEEK_TOOLS_DIR

# A mountpoint for Zeek's source tree
ENV VOL_SRC_DIR=/mnt/vol/src
# A mountpoint for the build tree
ENV VOL_BUILD_DIR=/mnt/vol/build
# A mountpoint for ccache's cache data
ENV VOL_CCACHE_DIR=/mnt/vol/ccache

VOLUME $VOL_SRC_DIR $VOL_BUILD_DIR $VOL_CCACHE_DIR
ENV CCACHE_DIR=/mnt/vol/ccache

COPY ./build-zeek.sh $ZEEK_TOOLS_DIR

ENTRYPOINT ["/zeek/tools/build-zeek.sh"]

