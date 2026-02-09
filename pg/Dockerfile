FROM postgres:18@sha256:3bb77a07b9ce8b8de0fe6d9b063adf20b9cca1068a1bcdc054cac71a69ce0ca6
COPY pg_hba.conf /var/lib/postgresql/
RUN openssl req -new -x509 -days 365 -nodes -text -out /var/lib/postgresql/server.crt -keyout /var/lib/postgresql/server.key -subj "/CN=vprodemo.com"
RUN chmod 600 /var/lib/postgresql/server.key
RUN chown postgres:postgres /var/lib/postgresql/server.key