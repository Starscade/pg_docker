FROM alpine

ENV LANG=en_US.utf8
ENV PGDATA=/var/lib/pgdata

RUN apk update                             && \
    apk upgrade                            && \
    apk add --no-cache  postgresql            \
                        postgresql-contrib && \
    install --directory                       \
            --group     postgres              \
            --mode 0700 "$PGDATA"             \
            --owner     postgres              \
                        /run/postgresql

USER postgres

STOPSIGNAL SIGINT

CMD [ "sh", "-c", "if [ ! -d \"$PGDATA/base\" ]; then initdb; fi && echo \"host all all 0.0.0.0/0 trust\" > \"$PGDATA/pg_hba.conf\" && echo \"local all all trust\" >> \"$PGDATA/pg_hba.conf\" && postgres -c listen_addresses='*'" ]
