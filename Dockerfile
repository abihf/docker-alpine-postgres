FROM alpine:edge

ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data

VOLUME /var/lib/postgresql/data
VOLUME /docker-entrypoint-initdb.d

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]

COPY docker-entrypoint.sh /

RUN apk -U add curl postgresql && \
    curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" && \
    mkdir -p /docker-entrypoint-initdb.d && \
    chmod +x /usr/local/bin/gosu && \
    apk del curl && \
    rm -rf /var/cache/apk/*


