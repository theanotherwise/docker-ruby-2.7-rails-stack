FROM ubuntu:focal

ARG WORK_DIR
ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="${WORK_DIR}/bin:${PATH}"

ENV USERNAME=redis
ENV WORK_DIR=${WORK_DIR}

RUN apt-get update && \
    apt-get install wget make gcc pkgconf -y

RUN wget https://download.redis.io/releases/redis-${VERSION}.tar.gz -O /tmp/redis-${VERSION}.tar.gz && \
    tar -xf /tmp/redis-${VERSION}.tar.gz -C /tmp --strip-components=1 && \
    make -C /tmp/

RUN useradd -s /bin/bash -m -d ${WORK_DIR} redis && \
    chmod 700 ${WORK_DIR} && \
    cd ${WORK_DIR} && \
    mkdir bin etc var && \
    mv /tmp/src/redis-server bin && \
    mv /tmp/src/redis-cli bin && \
    mv /tmp/redis.conf etc && \
    rm -rf /tmp/* && \
    chmod 700 bin etc var bin/* && \
    chmod 600 etc/* && \
    chown redis:redis -R ${WORK_DIR}

USER redis
WORKDIR "${WORK_DIR}"

COPY --chown=redis ./entrypoint.sh .
RUN chmod 600 entrypoint.sh

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]