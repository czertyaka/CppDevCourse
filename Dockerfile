FROM texlive/texlive:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-lang-cyrillic \
    && rm -rf /var/lib/apt/lists/*

ARG UNAME=cppdevcourse
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME

RUN tlmgr init-usertree && tlmgr install hyphenat

CMD /bin/bash
