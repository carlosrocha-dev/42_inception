FROM debian:bullseye-slim

RUN apt update && apt install -y lsb-release redis-server 


RUN echo "\nbind 0.0.0.0\nport 6379\nprotected-mode no\n" > /etc/redis/redis.conf

RUN mkdir /data && chown redis:redis /data

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]