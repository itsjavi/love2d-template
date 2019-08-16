.DEFAULT_GOAL := build

init:
	yarn install
.PHONY: init

build:
	./tools/build/build.sh
.PHONY: build

run:
	./tools/run.sh
.PHONY: run

.SILENT: init build run
