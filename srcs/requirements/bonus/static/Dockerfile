FROM debian:bullseye-slim

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY conf/package.json conf/package-lock.json ./

RUN npm install

COPY conf/ ./

EXPOSE 3000

CMD ["npm", "start"]