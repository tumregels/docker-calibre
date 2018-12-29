SHELL := /bin/bash

.PHONY: all build run compose

all: run

build:
	docker build -t calibre .

run:
	docker run -it --rm -e DISPLAY=$(DISPLAY) \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $(HOME)/.Xauthority:$(HOME)/.Xauthority \
	--net=host calibre

compose:
	docker-compose run --name calibre_master --rm calibre