# Docker organization to pull the images from
# credits: https://dev.to/flpslv/using-makefiles-to-build-and-publish-docker-containers-7c8

ORG=maila

# Docker TAG
TAG=latest

.PHONY: help build_maila_base build_maila_dev build push all

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo "TAG - image tag"
	    @echo "example: make build_maila_base TAG=v1"
	    @echo ""
	    @echo "Makefile commands:"
	    @echo "build_maila_base"
	    @echo "push_maila_base"
	    @echo "pull_maila_base"
	    @echo "build_maila_dev"
	    @echo "push_maila_dev"	    
	    @echo "pull_maila_dev"	
	    @echo "build"
	    @echo "push"
	    @echo "pull"	    
	    @echo "all"

.DEFAULT_GOAL := all

build_maila_base:
	docker build -t $(ORG)/maila-base:$(TAG) ./maila-base/.
	
build_maila_dev:
	docker build -t $(ORG)/maila-dev:$(TAG) ./maila-dev/.

push_maila_base:
	docker push $(ORG)/maila-base:$(TAG)
	
push_maila_dev:
	docker push $(ORG)/maila-dev:$(TAG)
		  
pull_maila_base:
	docker pull $(ORG)/maila-base:$(TAG)
	
pull_maila_dev:
	docker pull $(ORG)/maila-dev:$(TAG)
			  
build: build_maila_base build_maila_dev

push: push_maila_base push_maila_dev

push: pull_maila_base pull_maila_dev

run_maila_dev:
	docker run --rm -it \
		--name maila-container -h maila \
		--user "$(id -u):$(id -g)" \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--env DISPLAY=$DISPLAY \
		-p 2222:22 \
		$(ORG)/maila-dev:$(TAG)
	
run_maila_base:
	docker run --rm -it \
		--name maila-container -h maila \
		--user "$(id -u):$(id -g)" \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--env DISPLAY=$DISPLAY \
		-p 2222:22 \
		$(ORG)/maila-base:$(TAG)

connect:
	docker exec -u 0 -it maila-container bash
	
all: build push

