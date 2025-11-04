FROM postgres:18@sha256:b5b154cfe5bfed10a2e68f9d064ab76cebf28b4c80bedf714e6b500f839fbe9d
COPY pg_hba.conf /var/lib/postgresql/
RUN openssl req -new -x509 -days 365 -nodes -text -out /var/lib/postgresql/server.crt -keyout /var/lib/postgresql/server.key -subj "/CN=vprodemo.com"
RUN chmod 600 /var/lib/postgresql/server.key
RUN chown postgres:postgres /var/lib/postgresql/server.key