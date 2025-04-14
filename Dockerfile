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

# Check if group with GID exists, create if not
RUN if ! getent group $GID > /dev/null; then \
      groupadd -g $GID $UNAME; \
    fi

# Check if user with UID exists, create if not
RUN if ! getent passwd $UID > /dev/null; then \
      useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME; \
    fi

USER $UNAME
