FROM alpine

COPY testing.tar.xz /
COPY docker-entrypoint.sh /
COPY gosu-amd64 /usr/local/bin/gosu

ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data

#RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
#    apk update && apk add curl "postgresql@edge<9.6" "postgresql-contrib@edge<9.6" && \
#    mkdir /docker-entrypoint-initdb.d && \
#    curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" && \
#    chmod +x /usr/local/bin/gosu && \
#    apk del curl && \
#    rm -rf /var/cache/apk/*

RUN tar xJf /testing.tar.xz && \
    apk --allow-untrusted -X /testing -X http://nl.alpinelinux.org/alpine/edge/testing/ \
        -U add postgresql postgresql-contrib postgis && \
    mkdir /docker-entrypoint-initdb.d && \
    chmod +x /usr/local/bin/gosu && \
    apk del curl && \
    rm -rf /testing /testing.tar.xz /var/cache/apk/*

VOLUME /var/lib/postgresql/data
VOLUME /docker-entrypoint-initdb.d

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
