FROM gapsystem/gap-docker

MAINTAINER Alexander Konovalov <alexander.konovalov@st-andrews.ac.uk>

COPY --chown=1000:1000 . $HOME/unipoly

USER gap

WORKDIR $HOME/unipoly
