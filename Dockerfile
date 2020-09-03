FROM postgres:11-alpine as build
ADD https://github.com/HypoPG/hypopg/archive/1.1.2.tar.gz .
RUN tar -xvf 1.1.2.tar.gz && \
    apk add --update --no-cache build-base gcc make && \
    cd hypopg-1.1.2  && \
    make && \
    make install
FROM postgres:11-alpine as complete
COPY --from=build /usr/local/lib/postgresql/hypopg.so /usr/local/lib/postgresql/hypopg.so
COPY --from=build /usr/local/share/postgresql/extension/hypopg.control /usr/local/share/postgresql/extension/hypopg.control
COPY --from=build /usr/local/share/postgresql/extension/hypopg--1.1.2.sql /usr/local/share/postgresql/extension/hypopg--1.1.2.sql