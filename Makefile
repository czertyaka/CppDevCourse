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
	pr-5 \
	hw-1 \
	hw-2

all: build

build: \
	pr-1 \
	pr-2 \
	pr-3 \
	pr-4 \
	pr-5 \
	hw-1 \
	hw-2

install: build
	mkdir -p $(PREFIX)/Presentations
	cp pr-1.pdf "$(PREFIX)/Presentations/1 Введение.pdf"
	cp pr-2.pdf "$(PREFIX)/Presentations/2 Фазы трансляции.pdf"
	cp pr-3.pdf "$(PREFIX)/Presentations/3 Фундаментальные типы.pdf"
	cp pr-4.pdf "$(PREFIX)/Presentations/4 Переменные.pdf"
	cp pr-5.pdf "$(PREFIX)/Presentations/5 Циклы.pdf"
	mkdir -p $(PREFIX)/Homeworks
	cp hw-1.pdf "$(PREFIX)/Homeworks/1 Hello World.pdf"
	cp hw-2.pdf "$(PREFIX)/Homeworks/2 Git & Github.pdf"

clean:
	rm -rf \
		*.aux \
		*.fdb_latexmk \
		*.fls \
		*.listing \
		*.log \
		*.nav \
		*.out \
		*.pdf \
		*.snm \
		*.toc \
		*.vrb \
		_minted-*

help:
	@printf "all\tbuild all presentations and homeworks\n"
	@printf "build\tbuild all presentations and homeworks\n"
	@printf "install\tinstall all presentations and homeworks\n"
	@printf "clean\tremove build artifacts\n"
	@printf "help\tprint this message\n"
	@printf "pr-1\tbuild presentation pr-1.pdf\n"
	@printf "pr-2\tbuild presentation pr-2.pdf\n"
	@printf "pr-3\tbuild presentation pr-3.pdf\n"
	@printf "pr-4\tbuild presentation pr-4.pdf\n"
	@printf "pr-5\tbuild presentation pr-5.pdf\n"
	@printf "hw-1\tbuild homework hw-1.pdf\n"
	@printf "hw-2\tbuild homework hw-2.pdf\n"

pr-1: pr-1.pdf
pr-2: pr-2.pdf
pr-3: pr-3.pdf
pr-4: pr-4.pdf
pr-5: pr-5.pdf

hw-1: hw-1.pdf
hw-2: hw-2.pdf

dockerimage:
	docker build \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		-t cppdevcourse/texlive:latest \
		$(ROOT_DIR)

%.pdf: Dockerfile

define generate_pdf
	$(MAKE) dockerimage
	docker run \
		--rm \
		-u $(shell id -u):$(shell id -g) \
		-v $(ROOT_DIR):/workdir/ \
		-e TEXINPUTS='/workdir//:' \
		cppdevcourse/texlive:latest \
		latexmk \
			-halt-on-error \
			-shell-escape \
			-verbose \
			-lualatex \
			-jobname=$(subst .pdf,,$2) \
			$1
endef

pr-1.pdf: \
	Presentations/1-Intro/intro.tex \
	Presentations/presentationtemplate.sty \
	Presentations/images/binary-file.png \
	Presentations/images/source_code.png \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/1-Intro/*.cpp) \
	$(wildcard Presentations/1-Intro/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-2.pdf: \
	Presentations/2-Phases-of-translation/phases_of_translation.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/2-Phases-of-translation/*.cpp) \
	$(wildcard Presentations/2-Phases-of-translation/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-3.pdf: \
	Presentations/3-Fundamental-types/fundamental_types.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/3-Fundamental-types/*.cpp) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-4.pdf: \
	Presentations/4-Variables/variables.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/4-Variables/*cpp) \
	$(wildcard Presentations/4-Variables/*.h) \
	$(wildcard Presentations/4-Variables/**/*cpp) \
	$(wildcard Presentations/4-Variables/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-5.pdf: \
	Presentations/5-Selection-statements/selection-statements.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/5-Selection-statements/*cpp) \
	$(wildcard Presentations/5-Selection-statements/*.h) \
	$(wildcard Presentations/5-Selection-statements/**/*cpp) \
	$(wildcard Presentations/5-Selection-statements/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

hw-1.pdf: \
	Homeworks/1-Hello-World/hello_world.tex \
	Homeworks/homeworktemplate.sty \
	$(wildcard Homeworks/1-Hello-World/*.cpp) \
	$(wildcard Homeworks/1-Hello-World/*.txt) \
	$(wildcard Homeworks/1-Hello-World/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

hw-2.pdf: \
	Homeworks/2-Git/git.tex \
	Homeworks/homeworktemplate.sty \
	$(wildcard Homeworks/2-Git/**/*.cpp) \
	$(wildcard Homeworks/2-Git/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)
