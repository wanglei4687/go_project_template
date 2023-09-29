GOOS?=$(shell go env GOOS)
GOARCH?=$(shell go env GOARCH)
ifeq ($(GOARCH),arm)
	ARCH=armv7
else
	ARCH=$(GOARCH)
endif


GO_BUILD_RECIPE=\
	GOOS=$(GOOS) \
	GOARCH=$(GOARCH) \
	CGO_ENABLED=0 \
	go build

build: 
	$(info Build...)
	$(GO_BUILD_RECIPE) -o bin/main cmd/main/main.go