all: 
	mkdir -p /home/ael-youb/data/mariadb
	chmod -R 777 /home/ael-youb/data/mariadb
	mkdir -p /home/ael-youb/data/wordpress
	chmod -R 777 /home/ael-youb/data/wordpress
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
	@sudo rm -rf /home/hiisox/data/mariadb/*
	@sudo rm -rf /home/hiisox/data/wordpress/*
	@docker system prune -af
	docker volume rm srcs_mariadb
	docker volume rm srcs_wordpress

re: fclean all

.Phony: all logs clean fclean