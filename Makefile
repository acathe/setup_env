IMAGE = acathe/dev-environments-default
OS = linux
ARCH = arm64
GO_VERSION = 1.21.3

all:
	docker build \
	--build-arg OS=${OS} \
	--build-arg ARCH=${ARCH} \
	--build-arg GO_VERSION=${GO_VERSION} \
	--squash \
	-t $(IMAGE) .
