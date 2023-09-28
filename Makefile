PATH := bin:$(PATH)
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

.PHONY: fmt
fmt:
	$(info Format code...)
	@go fmt ./...

.PHONY: vet 
vet: 
	$(info Go static check...)
	@go vet ./...

.PHONY: test
test:
	$(info Run unit test...)
	@go test ./...

.PHONY: clean
clean:
	$(info Remove useless files)
	@rm bin/*

# golangci-lint
.PHONY: go-lint
go-lint: golangci-lint
	$(info Running golangci-lint...)
	$(GOLANGCI_LINT) run

GOLANGCI_LINT = $(shell pwd)/bin/golangci-lint
golangci-lint:
	$(call go-get-tool,$(GOLANGCI_LINT),github.com/golangci/golangci-lint/cmd/golangci-lint@v1.54.2)

# install tools
PROJECT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
define go-get-tool
@[ -f $(1) ] || { \
set -e; \
echo "Downloading $(2)"; \
GOBIN=$(PROJECT_DIR)/bin go install $(2); \
}
endef

# include other makefile
include make/build.mk