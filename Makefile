DOCKER_IMAGE := texlive/texlive:latest
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TEXFILES := \
	Presentations/1-Intro/intro.tex

PDFFILES := $(TEXFILES:%.tex=build/%.pdf)

define INSTALL_PDF
	$(eval FILE = $(1:build/%=%))
	$(eval INSTALL_DIR = $(PREFIX)/$(dir ${FILE}))
	mkdir -p ${INSTALL_DIR}
	cp $(1) ${INSTALL_DIR}
endef

.PHONY: \
	all \
	build \
	install \
	clean

all: build

build: $(PDFFILES)

install: build
	$(foreach PDFFILE,$(PDFFILES),$(call INSTALL_PDF,$(PDFFILE)))

clean:
	rm -rf texput.log build

build/%.pdf: %.tex
	mkdir -p build/$(dir $<)
	docker run \
		--rm \
		-u $(shell id -u):$(shell id -g) \
		-v $(ROOT_DIR):/workdir/ \
		-w /workdir/ \
		$(DOCKER_IMAGE) \
		pdflatex -output-directory=build/$(dir $<) $<

