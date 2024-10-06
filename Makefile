DOCKER_IMAGE := texlive/texlive:latest
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

%.pdf: %.tex
	mkdir -p build/$(dir $<)
	docker run \
		--rm \
		-u $(shell id -u):$(shell id -g) \
		-v $(ROOT_DIR):/workdir/ \
		-w /workdir/ \
		$(DOCKER_IMAGE) \
		pdflatex  -output-directory=build/$(dir $<) $<

intro-pr: Presentations/1-Intro/intro.pdf

clean:
	rm -rf build texput.log
