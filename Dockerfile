FROM alpine

ENV LANG=en_US.utf8
ENV PGDATA=/var/lib/pgdata

RUN \
	apk add --no-cache postgresql; \
	install --directory \
		--group postgres \
		--owner postgres \
		--mode 0700 "$PGDATA" \
		/run/postgresql;

USER postgres

STOPSIGNAL SIGINT

CMD [ "sh", "-c", "postgres || initdb && postgres" ]
