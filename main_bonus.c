#include "libasm.h"
#include <string.h>
#include <stdio.h>

void	print_list(t_list *lst)
{
	t_list	*tmp;

	tmp = lst;
	while (tmp)
	{
		printf("%s->", tmp->data);
		tmp = tmp->next;
	}
	printf("%s\n", "NULL");
}

void		push_front_test()
{
	t_list	*list;

	printf("\n-----push_front-----\n");
	list = NULL;
	print_list(list);
	ft_list_push_front(&list, "two");
	print_list(list);
	ft_list_push_front(&list, "one");
	print_list(list);
	ft_list_push_front(&list, NULL);
	print_list(list);
	ft_list_push_front(NULL, NULL);
	print_list(list);
}

void		list_size_test(int num)
{
	t_list	*list;

	list = NULL;
	int i = num;
	while (i--)
		ft_list_push_front(&list, "meow");
	if (ft_list_size(list) == num)
		printf("ft_list_size is OK for size %d\n", num);
	else
		printf("KO, expected %d, get %d\n", num, ft_list_size(list));
	print_list(list);
}

void		list_sort_test(void)
{
	t_list	*list;

	printf("\n-----list_sort-----\n");
	list = NULL;
	ft_list_push_front(&list, "test");
	ft_list_push_front(&list, "purr");
	ft_list_push_front(&list, "what");
	ft_list_push_front(&list, "ok");
	ft_list_push_front(&list, "meow");
	ft_list_push_front(&list, "one");
	ft_list_push_front(&list, "x");
	ft_list_push_front(&list, "azaza");
	printf("before:\n");
	print_list(list);
	ft_list_sort(&list, strcmp);
	printf("\nafter:\n");
	print_list(list);
	printf("\n");
}

void		list_remove_test(void)
{
	t_list	*list;

	printf("\n-----list_remove_if-----\n");
	list = NULL;
	ft_list_push_front(&list, "toto");
	ft_list_push_front(&list, "purr");
	ft_list_push_front(&list, "toto");
	ft_list_push_front(&list, "ok");
	ft_list_push_front(&list, "meow");
	ft_list_push_front(&list, "one");
	ft_list_push_front(&list, "toto");
	ft_list_push_front(&list, "toto");
	printf("before:\n");
	print_list(list);
	ft_list_remove_if(&list, "toto", &strcmp);
	printf("\nafter:\n");
	print_list(list);
	printf("\n");
}

int		main()
{
	//printf("\n-----list_size-----\n");
	//list_size_test(5);
	//list_size_test(0);

	//push_front_test();

	//list_sort_test();
	list_remove_test();
	return 0;

}