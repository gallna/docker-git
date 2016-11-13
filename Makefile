.PHONY: build push release
.DEFAULT_GOAL := build
BASENAME=gallna/git
TAGs=$(shell docker images -a | grep ${BASENAME} | awk '{print $2}')
LAST_TAG=$(shell egrep -o '[0-9]$')

build:
	docker build -t gallna/git:ssh .

push:
	docker tag gallna/git:ssh gallna/git:ssh:latest
	docker push gallna/git:ssh
	docker push gallna/git:ssh:latest

release: build push
