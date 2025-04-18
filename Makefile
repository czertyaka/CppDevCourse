ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: \
	all \
	build \
	clean \
	dockerimage \
	help \
	hw-1 \
	hw-2 \
	hw-3 \
	install \
	pr-1 \
	pr-10 \
	pr-11 \
	pr-12 \
	pr-2 \
	pr-3 \
	pr-4 \
	pr-5 \
	pr-6 \
	pr-7 \
	pr-8 \
	pr-9 \
	prj-auth-lib \
	prj-enc-exch

all: build

build: \
	hw-1 \
	hw-2 \
	hw-3 \
	pr-1 \
	pr-10 \
	pr-11 \
	pr-12 \
	pr-2 \
	pr-3 \
	pr-4 \
	pr-5 \
	pr-6 \
	pr-7 \
	pr-8 \
	pr-9 \
	prj-auth-lib \
	prj-enc-exch

install: build
	mkdir -p "$(PREFIX)/Презентации"
	cp pr-1.pdf "$(PREFIX)/Презентации/1 Введение.pdf"
	cp pr-2.pdf "$(PREFIX)/Презентации/2 Фазы трансляции.pdf"
	cp pr-3.pdf "$(PREFIX)/Презентации/3 Фундаментальные типы.pdf"
	cp pr-4.pdf "$(PREFIX)/Презентации/4 Переменные.pdf"
	cp pr-5.pdf "$(PREFIX)/Презентации/5 Условия.pdf"
	cp pr-6.pdf "$(PREFIX)/Презентации/6 Циклы.pdf"
	cp pr-7.pdf "$(PREFIX)/Презентации/7 Указатели и ссылки.pdf"
	cp pr-8.pdf "$(PREFIX)/Презентации/8 Массивы.pdf"
	cp pr-9.pdf "$(PREFIX)/Презентации/9 Функции.pdf"
	cp pr-10.pdf "$(PREFIX)/Презентации/10 Приведения типов.pdf"
	cp pr-11.pdf "$(PREFIX)/Презентации/11 Структуры и классы.pdf"
	cp pr-12.pdf "$(PREFIX)/Презентации/12 Виртуальные методы и полиморфизм.pdf"
	mkdir -p "$(PREFIX)/Домашние задания"
	cp hw-1.pdf "$(PREFIX)/Домашние задания/1 Hello World.pdf"
	cp hw-2.pdf "$(PREFIX)/Домашние задания/2 Git & Github.pdf"
	cp hw-3.pdf "$(PREFIX)/Домашние задания/3 Two Sum.pdf"
	mkdir -p "$(PREFIX)/Проекты"
	cp prj-auth-lib.pdf "$(PREFIX)/Проекты/Библиотека идентификации и аутентификации.pdf"
	cp prj-enc-exch.pdf "$(PREFIX)/Проекты/Baremetal шифрование обмена.pdf"

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
		_minted*

help:
	@printf "all\tbuild all presentations and homeworks\n"
	@printf "build\tbuild all presentations and homeworks\n"
	@printf "clean\tremove build artifacts\n"
	@printf "help\tprint this message\n"
	@printf "hw-1\tbuild homework hw-1.pdf\n"
	@printf "hw-2\tbuild homework hw-2.pdf\n"
	@printf "hw-3\tbuild homework hw-3.pdf\n"
	@printf "install\tinstall all presentations and homeworks\n"
	@printf "pr-10\tbuild presentation pr-10.pdf\n"
	@printf "pr-11\tbuild presentation pr-11.pdf\n"
	@printf "pr-1\tbuild presentation pr-1.pdf\n"
	@printf "pr-2\tbuild presentation pr-2.pdf\n"
	@printf "pr-3\tbuild presentation pr-3.pdf\n"
	@printf "pr-4\tbuild presentation pr-4.pdf\n"
	@printf "pr-5\tbuild presentation pr-5.pdf\n"
	@printf "pr-6\tbuild presentation pr-5.pdf\n"
	@printf "pr-7\tbuild presentation pr-7.pdf\n"
	@printf "pr-8\tbuild presentation pr-8.pdf\n"
	@printf "pr-9\tbuild presentation pr-9.pdf\n"
	@printf "prj-auth-lib\tbuild project prj-auth-lib.pdf\n"
	@printf "prj-enc-exch\tbuild project prj-enc-exch.pdf\n"

pr-1: pr-1.pdf
pr-2: pr-2.pdf
pr-3: pr-3.pdf
pr-4: pr-4.pdf
pr-5: pr-5.pdf
pr-6: pr-6.pdf
pr-7: pr-7.pdf
pr-8: pr-8.pdf
pr-9: pr-9.pdf
pr-10: pr-10.pdf
pr-11: pr-11.pdf
pr-12: pr-12.pdf

hw-1: hw-1.pdf
hw-2: hw-2.pdf
hw-3: hw-3.pdf

prj-auth-lib: prj-auth-lib.pdf
prj-enc-exch: prj-enc-exch.pdf

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
	$(wildcard Presentations/4-Variables/*.cpp) \
	$(wildcard Presentations/4-Variables/*.h) \
	$(wildcard Presentations/4-Variables/**/*.cpp) \
	$(wildcard Presentations/4-Variables/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-5.pdf: \
	Presentations/5-Selection-statements/selection-statements.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/5-Selection-statements/*.cpp) \
	$(wildcard Presentations/5-Selection-statements/*.h) \
	$(wildcard Presentations/5-Selection-statements/**/*.cpp) \
	$(wildcard Presentations/5-Selection-statements/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-6.pdf: \
	Presentations/6-Iteration-statements/iteration-statements.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/6-Iteration-statements/*.cpp) \
	$(wildcard Presentations/6-Iteration-statements/*.h) \
	$(wildcard Presentations/6-Iteration-statements/**/*.cpp) \
	$(wildcard Presentations/6-Iteration-statements/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-7.pdf: \
	Presentations/7-Pointers-and-References/ptrs-and-refs.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/7-Pointers-and-References/*.cpp) \
	$(wildcard Presentations/7-Pointers-and-References/*.h) \
	$(wildcard Presentations/7-Pointers-and-References/**/*.cpp) \
	$(wildcard Presentations/7-Pointers-and-References/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-8.pdf: \
	Presentations/8-Arrays/arrays.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/8-Arrays/*.cpp) \
	$(wildcard Presentations/8-Arrays/*.h) \
	$(wildcard Presentations/8-Arrays/**/*.cpp) \
	$(wildcard Presentations/8-Arrays/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-9.pdf: \
	Presentations/9-Functions/functions.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/9-Functions/*.cpp) \
	$(wildcard Presentations/9-Functions/*.h) \
	$(wildcard Presentations/9-Functions/**/*.cpp) \
	$(wildcard Presentations/9-Functions/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-10.pdf: \
	Presentations/10-Conversions/conversions.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/10-Conversions/*.cpp) \
	$(wildcard Presentations/10-Conversions/*.h) \
	$(wildcard Presentations/10-Conversions/**/*.cpp) \
	$(wildcard Presentations/10-Conversions/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-11.pdf: \
	Presentations/11-Structs-and-classes/structs-and-classes.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-12.pdf: \
	Presentations/12-Virtual-members/virtual-members.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
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

hw-3.pdf: \
	Homeworks/3-TwoSum/two-sum.tex \
	Homeworks/homeworktemplate.sty \
	$(wildcard Homeworks/3-TwoSum/**/*.cpp) \
	$(wildcard Homeworks/3-TwoSum/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

prj-auth-lib.pdf: \
	Projects/Identification-and-Authentication-Library/auth-library.tex \
	$(wildcard Projects/images/*.jpg) \
	Packages/mylisting.sty \
	Projects/projectstemplate.sty
	$(call generate_pdf,$<,$@)
	
prj-enc-exch.pdf: \
	Projects/Baremetal-exchange-encryption/exchange-encryption.tex \
	$(wildcard Projects/images/*.jpg) \
	Packages/mylisting.sty \
	Projects/projectstemplate.sty
	$(call generate_pdf,$<,$@)
