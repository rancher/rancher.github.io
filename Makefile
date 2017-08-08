CWD = $(shell pwd)

build:
	docker run --rm --label=jekyll --volume=$(CWD):/srv/jekyll  \
	-it -p 4000:4000 jekyll/jekyll jekyll serve
