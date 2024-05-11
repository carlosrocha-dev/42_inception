# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/01 23:35:52 by caalbert          #+#    #+#              #
#    Updated: 2024/04/11 13:32:21 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

USER_HOME = $(HOME)
DATA_DIR = $(USER_HOME)/data

all: up

up:
	sudo chmod 777 /etc/hosts
	sudo grep -q "127.0.0.1 caalbert.42.fr" /etc/hosts || echo "127.0.0.1 caalbert.42.fr" | sudo tee -a /etc/hosts > /dev/null
	sudo mkdir -p $(DATA_DIR)/wordpress && sudo chmod 777 $(DATA_DIR)/wordpress
	sudo mkdir -p $(DATA_DIR)/mariadb && sudo chmod 777 $(DATA_DIR)/mariadb
	sudo mkdir -p $(DATA_DIR)/static-files && sudo chmod 777 $(DATA_DIR)/static-files
	sudo docker-compose -f srcs/docker-compose.yml up -d

down:
	sudo docker-compose -f srcs/docker-compose.yml down

rebuild: docker-clean
	sudo docker-compose -f srcs/docker-compose.yml build --no-cache
	sudo docker-compose -f srcs/docker-compose.yml up -d

clean:
	sudo docker-compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans
	sudo sed -i '/127.0.0.1 caalbert.42.fr/d' /etc/hosts
	sudo rm -rf $(DATA_DIR)/wordpress
	sudo rm -rf $(DATA_DIR)/mariadb
	sudo rm -rf $(DATA_DIR)/static-files

docker-clean:
	@CONTAINERS=$$(sudo docker ps -aq); \
	if [ -n "$$CONTAINERS" ]; then \
		sudo docker stop $$CONTAINERS; \
		sudo docker rm $$CONTAINERS; \
	fi
	@IMAGES=$$(sudo docker images -qa); \
	if [ -n "$$IMAGES" ]; then \
		sudo docker rmi -f $$IMAGES; \
	fi
	@VOLUMES=$$(sudo docker volume ls -q); \
	if [ -n "$$VOLUMES" ]; then \
		sudo docker volume rm $$VOLUMES; \
	fi
	@NETWORKS=$$(sudo docker network ls -q 2>/dev/null | grep -v "bridge\|host\|none"); \
	if [ -n "$$NETWORKS" ]; then \
		sudo docker network rm $$NETWORKS; \
	fi


fclean: clean docker-clean

re: fclean all

.PHONY: all up down rebuild clean fclean re docker-clean
