NAME		=	libasm.a
MAIN_SRC	=	ft_write.s ft_read.s ft_strlen.s ft_strdup.s ft_strcpy.s ft_strcmp.s
MAIN_OBJ	=	$(addprefix $(O_DIR)/, $(MAIN_SRC:.s=.o))
BONUS_SRC	=	ft_list_size_bonus.s ft_list_push_front_bonus.s \
				ft_list_sort_bonus.s ft_list_remove_if_bonus.s ft_atoi_base_bonus.s
BONUS_OBJ	=	$(addprefix $(O_DIR)/, $(BONUS_SRC:.s=.o))
O_DIR		=	./bin
FLAGS		=	-Wall -Wextra -Werror

ifdef WITH_BONUS
SRC		=	$(BONUS_SRC) $(MAIN_SRC)
OBJ		=	$(BONUS_OBJ) $(MAIN_OBJ)
else
SRC		=	$(MAIN_SRC)
OBJ		=	$(MAIN_OBJ)
endif

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(OBJ)
	@ar rc $@ $?
	@ranlib $@
	@echo "$(NAME) compiled"

$(O_DIR)/%.o: %.s | $(O_DIR)
	nasm -f macho64 $< -o $@

$(O_DIR):
	@mkdir $(O_DIR)

bonus:
	@$(MAKE) WITH_BONUS=1 all

clean:
	@rm -rf $(O_DIR)
	@rm -rf ./test.txt
	@echo "$(NAME) object files deleted"

fclean: clean
	@rm -rf $(NAME)
	@echo "$(NAME) deleted"

test: $(NAME) main.c libasm.h
	@rm -rf ./test.txt
	gcc -L. -lasm -o test main.c
	./test < Makefile
	@rm -rf ./test

testb: main_bonus.c libasm.h
	@$(MAKE) bonus
	gcc -L. -lasm -o test main_bonus.c
	./test
	@rm -rf ./test

re: fclean all
