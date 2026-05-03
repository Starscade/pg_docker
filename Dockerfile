FROM alpine

RUN set -eux; \
	addgroup -g 70 -S postgres; \
	adduser -u 70 -S -D -G postgres -H -h /var/lib/postgresql -s /bin/sh postgres; \
	install --verbose --directory --owner postgres --group postgres --mode 1777 /var/lib/postgresql; \
	apk add --no-cache postgresql;

ENV LANG=en_US.utf8

RUN mkdir /docker-entrypoint-initdb.d

RUN install --verbose --directory --owner postgres --group postgres --mode 3777 /var/run/postgresql

ENV PGDATA=/var/lib/postgresql/18/docker

VOLUME /var/lib/postgresql

STOPSIGNAL SIGINT

EXPOSE 5432

USER postgres

CMD [ "sh", "-c", "postgres || initdb && postgres" ]
