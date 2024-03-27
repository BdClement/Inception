NAME = Inception

DC_PATH = srcs/docker-compose.yml

RED = \033[0;31m
GREEN = \033[0;32m
RESET = \033[0m

all :
	@echo "$(GREEN)Launching $(NAME)$(RESET)"
	@docker compose -f $(DC_PATH) build
	@docker compose -f $(DC_PATH) up
	@docker compose -f $(DC_PATH) logs -f

down :
	@echo "$(RED)$(NAME) down$(RESET)"
	@docker compose -f $(DC_PATH) down

up :
	@echo "$(GREEN) $(NAME) up$(RESET)"
	@docker compose -f $(DC_PATH) up

img :	
	@echo "$(GREEN)Checking images avalaible$(RESET)"
	@docker image ls

ps:
	@echo "$(GREEN)Checking running containers$(RESET)"
	@docker ps      

clear_volumes :
	@echo "$(RED)Removing the $(NAME)'s volumes$(RESET)"
	@rm -rf /home/clbernar/data/mariadb/*
	@rm -rf /home/clbernar/data/wordpress/*

clean : down
	@echo "$(RED)Cleaning $(NAME)$(RESET)"
	@docker system prune -af

fclean : clean

re : fclean all

PHONY : all down up clean fclean re
