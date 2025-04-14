FROM texlive/texlive:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-lang-cyrillic \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    && rm -rf /var/lib/apt/lists/*

ARG UNAME=cppdevcourse
ARG UID=1000
ARG GID=1000
RUN groupadd -f -g $GID $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME
