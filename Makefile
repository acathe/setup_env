IMAGE := acathe/dev-environments-default
GO_VERSION := 1.21.5

all:
	docker build \
	--build-arg GO_VERSION=$(GO_VERSION) \
	-t $(IMAGE) .

test:
	docker build \
	--build-arg GO_VERSION=$(GO_VERSION) \
	--no-cache --progress=plain \
	-t test .
	docker image rm test
	docker builder prune

clean:
	docker image rm $(IMAGE)
	docker builder prune
