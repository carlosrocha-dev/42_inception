FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && apt install -y \
        nginx \
        openssl

RUN mkdir -p /etc/nginx/ssl && \
        openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
        -keyout /etc/nginx/ssl/signedcert.key \
        -out /etc/nginx/ssl/signedcert.crt \
        -subj "/C=BR/ST=SP/L=SP/O=42/CN=$DOMAIN_NAME/UID=caalbert"

COPY ./conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
