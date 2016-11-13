.PHONY: build push release
.DEFAULT_GOAL := build
BASENAME=gallna/git
LAST_TAG=$(shell docker images -a | grep ${BASENAME} | awk '{print $2}' | | egrep -o '^\d*')
TAG_MINOR=$(shell egrep -o '[0-9]$')

build:
	docker build -t gallna/git:git .

push:
	docker push gallna/git:git

release: build push
