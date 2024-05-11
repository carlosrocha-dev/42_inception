#!/bin/sh

sudo mkdir -p /home/user42/data/static-files
sudo chmod 777 /home/user42/data/static-files
exec "$@"
