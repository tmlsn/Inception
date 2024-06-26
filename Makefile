all: 
	mkdir -p /home/tmalless/data/mariadb
	chmod -R 777 /home/tmalless/data/mariadb
	mkdir -p /home/tmalless/data/wordpress
	chmod -R 777 /home/tmalless/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	docker container stop nginx mariadb wordpress
	docker network rm inception

fclean: clean
	@docker system prune -af

superclean: fclean
	@sudo rm -rf /home/tmalless/data/mariadb/*
	@sudo rm -rf /home/tmalless/data/wordpress/*
#	docker volume rm srcs_mariadb
#	docker volume rm srcs_wordpress

re: fclean all

.Phony: all logs clean fclean superclean