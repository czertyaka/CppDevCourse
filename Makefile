ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TEXFILES := \
	$(ROOT_DIR)/Presentations/1-Intro/intro.tex \
	$(ROOT_DIR)/Presentations/2-Phases-of-translation/phases_of_translation.tex \
	$(ROOT_DIR)/Homeworks/1-SetUp/set-up.tex

PDFFILES := $(TEXFILES:$(ROOT_DIR)/%.tex=build/%.pdf)

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
	clean \
	dockerimage

all: build

build: $(PDFFILES)

install: build
	$(foreach PDFFILE,$(PDFFILES),$(call INSTALL_PDF,$(PDFFILE)))

clean:
	rm -rf texput.log build

build/%.pdf: %.tex Dockerfile
	$(MAKE) dockerimage
	mkdir -p build/$(dir $<)
	docker run \
		--rm \
		-u $(shell id -u):$(shell id -g) \
		-v $(ROOT_DIR):/workdir/ \
		-e TEXINPUTS='/workdir//:' \
		cppdevcourse/texlive:latest \
		latexmk \
			-synctex=1 \
			-latexoption='-halt-on-error -enable-etex' \
			-xelatex \
			-output-directory=build/$(dir $<) \
			$<

dockerimage:
	docker build \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		-t cppdevcourse/texlive:latest \
		$(ROOT_DIR)
