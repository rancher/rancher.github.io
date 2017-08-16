.PHONY: default build build-nginx run

default: build build-nginx run

# this target sets up Jekyll, and uses it to build html
build:
	docker build -t rancher/rancher.github.io:build -f Dockerfile.build .

# this target uses the Jekyll html image in a multistage Dockerfile to build a small nginx image
build-nginx:
	docker build -t rancher/rancher.github.io .

run:
	docker run -p 80:80 rancher/rancher.github.io
