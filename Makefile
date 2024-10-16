ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TEXFILES := \
	$(ROOT_DIR)/Presentations/1-Intro/intro.tex \
	$(ROOT_DIR)/Presentations/2-Phases-of-translation/phases_of_translation.tex \
	$(ROOT_DIR)/Homeworks/1-Hello-World/hello_world.tex

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
	dockerimage \
	help \
	pr-1 \
	pr-2 \
	hw-1

all: build

build: $(PDFFILES)

install: build
	$(foreach PDFFILE,$(PDFFILES),$(call INSTALL_PDF,$(PDFFILE)))

clean:
	rm -rf texput.log build

help:
	@printf "all\tbuild all presentations and homeworks\n"
	@printf "build\tbuild all presentations and homeworks\n"
	@printf "clean\tremove build artifacts\n"
	@printf "help\tprint this message\n"
	@printf "install\tinstall all presentations and homeworks to <PREFIX>\n"
	@printf "pr-1\tbuild presentation intro.pdf\n"
	@printf "pr-2\tbuild presentation phases_of_translation.pdf\n"
	@printf "hw-1\tbuild homework hello_world.pdf\n"

pr-1: build/Presentations/1-Intro/intro.pdf
pr-2: build/Presentations/2-Phases-of-translation/phases_of_translation.pdf

hw-1: build/Homeworks/1-Hello-World/hello_world.pdf

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
			-latexoption='-halt-on-error' \
			-xelatex \
			-output-directory=build/$(dir $<) \
			$<

dockerimage:
	docker build \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		-t cppdevcourse/texlive:latest \
		$(ROOT_DIR)

build/Presentations/1-Intro/intro.pdf: \
	Presentations/presentationtemplate.sty \
	Presentations/images/binary-file.png \
	Presentations/images/source_code.png \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/1-Intro/*.cpp) \
	$(wildcard Presentations/1-Intro/*.h) \
	Presentations/Packages/prconsolewindow.sty \
	Presentations/Packages/prlisting.sty

build/Presentations/2-Phases-of-translation/phases_of_translation.pdf: \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/2-Phases-of-translation/*.cpp) \
	$(wildcard Presentations/2-Phases-of-translation/*.h) \
	Presentations/Packages/prconsolewindow.sty \
	Presentations/Packages/prlisting.sty

build/Homeworks/1-Hello-World/hello_world.pdf: \
	Homeworks/homeworktemplate.sty \
	$(wildcard Homeworks/1-Hello-World/*.cpp) \
	$(wildcard Homeworks/1-Hello-World/*.txt) \
	$(wildcard Homeworks/1-Hello-World/*.h) \
	Packages/consolewindow.sty \
	Packages/cpplisting.sty
