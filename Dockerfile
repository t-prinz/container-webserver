FROM registry.access.redhat.com/ubi8

LABEL maintainer="Trey Prinz"

ENV PORT=8000 \
    WORKING_DIR=/web-app

RUN yum module install -y python39 && \
    yum clean all

RUN mkdir ${WORKING_DIR} && \
    echo "This is the default web server file." > ${WORKING_DIR}/index.html

ONBUILD COPY files/ ${WORKING_DIR}

RUN chgrp -R 0 ${WORKING_DIR} && \
    chmod g=u ${WORKING_DIR}

EXPOSE ${PORT}

USER 1001

WORKDIR ${WORKING_DIR}

CMD python3 -m http.server
