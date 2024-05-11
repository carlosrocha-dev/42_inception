FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && apt install -y \
        mariadb-server \
        mariadb-client

RUN mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 755 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/entrypoint.sh entrypoint.sh

RUN chmod a+x entrypoint.sh

USER mysql

EXPOSE 3306

ENTRYPOINT [ "/entrypoint.sh" ]
