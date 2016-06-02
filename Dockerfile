FROM abihf/alpine-postgres:latest

RUN apk -U add curl && \
    curl -L https://github.com/Rushmorefm/alpine-packages/releases/download/v0.1/testing.tar.xz | tar xJ && \
    apk --allow-untrusted -X /testing -X http://nl.alpinelinux.org/alpine/edge/testing/ \
        -U add postgresql-contrib postgis && \
    rm -rf /testing /var/cache/apk/*

