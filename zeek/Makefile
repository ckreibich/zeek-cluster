zeek-image: prebuild-image build-image final-image

prebuild-image:
	docker build -t zeek/prebuild ./docker.prebuild

build-image:
	docker rm -f zeek-builder
	docker run --name zeek-builder -v "$$(pwd)/../../zeek:/mnt/vol/src:z" -v "$$(pwd)/ccache:/mnt/vol/ccache:z" -v "$$(pwd)/build:/mnt/vol/build:z" zeek/prebuild
	docker commit zeek-builder zeek/build

final-image:
	docker build -t zeek/zeek ./docker.final
