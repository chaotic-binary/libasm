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

/*void	print_list_int(t_list *lst)
{
	t_list	*tmp;

	tmp = lst;
	while (tmp)
	{
		printf("%i->", tmp->data);
		tmp = tmp->next;
	}
	printf("%s\n", "NULL");
}*/

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

/*
void		push_front_test_intlist()
{
	t_list	*list;

	printf("\n-----push_front-----\n");
	list = NULL;
	print_list(list);
	ft_list_push_front(&list, 2);
	print_list_int(list);
	ft_list_push_front(&list, 1);
	print_list_int(list);
	ft_list_push_front(&list, NULL);
	print_list_int(list);
	ft_list_push_front(NULL, NULL);
	print_list_int(list);
}
*/

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

int		ft_strcmp_noseg(char *str1, char *str2)
{
	unsigned char	*s1;
	unsigned char	*s2;

	if (str1 == NULL || str2 == NULL)
		return (0);
	s1 = (unsigned char *)str1;
	s2 = (unsigned char *)str2;
	while (*s1 == *s2 && *s1)
	{
		s1++;
		s2++;
	}
	return (*s1 - *s2);
}

void		list_sort_test(void)
{
	t_list	*list;

	printf("\n-----list_sort-----\n");
	list = NULL;
	ft_list_push_front(&list, "2");
	ft_list_push_front(&list, "4");
	ft_list_push_front(&list, "3");
	ft_list_push_front(&list, "1");
	ft_list_push_front(&list, "2");
	ft_list_push_front(&list, "5");

	//ft_list_push_front(&list, NULL);
	printf("before:\n");
	print_list(list);
	printf("\nafter sort:\n");
	ft_list_sort(&list, &ft_strcmp);
	print_list(list);
	printf("\n");
	//no segfault test
	ft_list_sort(NULL, ft_strcmp_noseg);
	ft_list_sort(NULL, NULL);
}

void		list_remove_test(void)
{
	t_list	*list;

	printf("\n-----list_remove_if-----\n");
	list = NULL;
	ft_list_push_front(&list, "DELETEME");
	ft_list_push_front(&list, "purr");
	ft_list_push_front(&list, "DELETEME");
	ft_list_push_front(&list, "ok");
	ft_list_push_front(&list, "meow");
	ft_list_push_front(&list, "one");
	ft_list_push_front(&list, "DELETEME");
	ft_list_push_front(&list, "DELETEME");
	printf("before:\n");
	print_list(list);
	ft_list_remove_if(&list, "DELETEME", &strcmp);
	printf("\nafter remove:\n");
	print_list(list);
	printf("\n");
}

void		atoi_base_test()
{
	# define ATOI_BASE(s, b)	i = ft_atoi_base(s, b); printf("`%s` [base %d] = %d [base 10]\n", s, b, i);

	printf("\n-----atoi_base-----\n");
	int	i = 0;
	ATOI_BASE("42", 10)
	ATOI_BASE("0", 10)
	ATOI_BASE("-0", 10)
	ATOI_BASE("-42", 10)
	ATOI_BASE("--42", 10)
	ATOI_BASE("++42", 10)
	ATOI_BASE("-+-42", 10)
	ATOI_BASE("-+-+-+42", 10)
	ATOI_BASE("-+-+-+-42", 10)
	ATOI_BASE("2147483647", 10)
	ATOI_BASE("2147483648", 10)
	ATOI_BASE("-2147483648", 10)
	ATOI_BASE("0", 2)
	ATOI_BASE("1", 2)
	ATOI_BASE("2", 2)
	ATOI_BASE("2a", 16)
	ATOI_BASE("ff", 16)
	ATOI_BASE("10", 16)
	ATOI_BASE("x", 'x')
	ATOI_BASE("8", '\t')
	ATOI_BASE("    +42", 10)
	ATOI_BASE("    -42", 10)
	ATOI_BASE("    42", 10)
	ATOI_BASE("  \t\n\r\v\f  10", 8)
	ATOI_BASE("  \t\n\r\v\f  -10", 8)
	ATOI_BASE("52", 8)
	ATOI_BASE("42meow !", 8)
	ATOI_BASE("-42meow !", 8)
	ATOI_BASE("school 42", 10)
}

int		main()
{
	printf("\n-----list_size-----\n");
	list_size_test(0);
	list_size_test(5);
	push_front_test();
	list_sort_test();
	list_remove_test();
	atoi_base_test();
	return 0;
}
