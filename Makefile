ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: \
	all \
	build \
	install \
	clean \
	dockerimage \
	help \
	pr-1 \
	pr-2 \
	pr-3 \
	pr-4 \
	hw-1

all: build

build: \
	pr-1 \
	pr-2 \
	pr-3 \
	pr-4 \
	hw-1

install:
	mkdir -p $(PREFIX)/Presentations
	cp build/Presentations/1-Intro/intro.pdf "$(PREFIX)/Presentations/1 Введение.pdf"
	cp build/Presentations/2-Phases-of-translation/phases_of_translation.pdf "$(PREFIX)/Presentations/2 Фазы трансляции.pdf"
	cp build/Presentations/3-Fundamental-types/fundamental_types.pdf "$(PREFIX)/Presentations/3 Фундаментальные типы.pdf"
	cp build/Presentations/4-Variables/variables.pdf "$(PREFIX)/Presentations/4 Переменные.pdf"
	mkdir -p $(PREFIX)/Homeworks
	cp build/Homeworks/1-Hello-World/hello_world.pdf "$(PREFIX)/Homeworks/1 Hello World.pdf"

clean:
	rm -rf texput.log build

help:
	@printf "all\tbuild all presentations and homeworks\n"
	@printf "build\tbuild all presentations and homeworks\n"
	@printf "clean\tremove build artifacts\n"
	@printf "help\tprint this message\n"
	@printf "pr-1\tbuild presentation intro.pdf\n"
	@printf "pr-2\tbuild presentation phases_of_translation.pdf\n"
	@printf "pr-3\tbuild presentation fundamental_types.pdf\n"
	@printf "hw-1\tbuild homework hello_world.pdf\n"

pr-1: build/Presentations/1-Intro/intro.pdf
pr-2: build/Presentations/2-Phases-of-translation/phases_of_translation.pdf
pr-3: build/Presentations/3-Fundamental-types/fundamental_types.pdf
pr-4: build/Presentations/4-Variables/variables.pdf

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
	Packages/terminal.sty \
	Packages/mylisting.sty

build/Presentations/2-Phases-of-translation/phases_of_translation.pdf: \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/2-Phases-of-translation/*.cpp) \
	$(wildcard Presentations/2-Phases-of-translation/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty

build/Presentations/3-Fundamental-types/fundamental_types.pdf: \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/3-Fundamental-types/*.cpp) \
	Packages/terminal.sty \
	Packages/mylisting.sty

build/Presentations/4-Variables/variables.pdf: \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/4-Variables/*cpp) \
	$(wildcard Presentations/4-Variables/*.h) \
	$(wildcard Presentations/4-Variables/**/*cpp) \
	$(wildcard Presentations/4-Variables/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty

build/Homeworks/1-Hello-World/hello_world.pdf: \
	Homeworks/homeworktemplate.sty \
	$(wildcard Homeworks/1-Hello-World/*.cpp) \
	$(wildcard Homeworks/1-Hello-World/*.txt) \
	$(wildcard Homeworks/1-Hello-World/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
