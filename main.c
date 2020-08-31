
#include "libasm.h"
#include <string.h>
#include <stdio.h>
#include <fcntl.h>

void	test_read(void)
{
	int		i;
	long	rd;
	char	buffer[100];

	printf("\n-----read-----\n");
	i = 0;
	rd = 0;
	while (i < 100)
		buffer[i++] = 0;

	rd = ft_read(0, buffer, 0);
	printf("for empty string `%s` ft_read returns: %ld\n", buffer, rd);
	rd = read(0, buffer, 0);
	printf("for empty string `%s` read returns: %ld\n", buffer, rd);

	rd = ft_read(-1, buffer, 50);
	printf("for fd = -1 ft_read returns %ld, errno = %d\n", rd, errno);
	rd = read(-1, buffer, 50);
	printf("for fd = -1 read returns %ld, errno = %d\n", rd, errno);

	rd = ft_read(STDIN_FILENO, buffer, 10);
	printf("1st 10 symbols of Makefile is: `%s`:%ld\n", buffer, rd);
}

void	test_write(void)
{
	long	myret;
	long	exret;
	int		fd;

	printf("\n-----write-----\n");

	myret = ft_write(1, "toto\n", 5);
	exret = write(1, "toto\n", 5);
	if (myret != exret)
		printf("ft_write returns %ld\n, write returns %ld\n", myret, exret);

	myret = ft_write(1, "to\nto", 3);
	exret = write(1, "to\nto", 3);
	if (myret != exret)
		printf("ft_write returns %ld\n, write returns %ld\n", myret, exret);

	myret = ft_write(1, NULL, 4);
	exret = write(1, NULL, 4);
	if (myret != exret)
		printf("ft_write returns %ld\n, write returns %ld\n", myret, exret);

	errno = 0;
	myret = ft_write(-1, "toto", 4);
	printf("ft_write errno = %d\n", errno);
	exret = write(-1, "toto", 4);
	printf("   write errno = %d\n", errno);
	if (myret != exret)
		printf("ft_write returns %ld\n, write returns %ld\n", myret, exret);

	errno = 0;
	fd = open("test.txt", O_CREAT | O_APPEND | O_WRONLY, 0755);
	ft_write(fd, "   Look at the file and find ", 29);
	printf("ft_write errno = %d\n", errno);
	write(fd, "that I can write ", 17);
	printf("   write errno = %d\n", errno);
	close(fd);

	errno = 0;
	fd = open("test.txt", O_WRONLY);
	ft_write(fd, "!", 1);
	printf("ft_write errno = %d\n", errno);
	write(fd, "?", 1);
	printf("   write errno = %d\n", errno);
	close(fd);

	myret = ft_write(3,"toto", 4);
	exret = write(3,"toto", 4);
	if (myret != exret)
		printf("ft_write returns %ld\n, write returns %ld\n", myret, exret);
	myret = ft_write(3,"toto", 0);
	exret = write(3,"toto", 0);
	if (myret != exret)
		printf("ft_write returns %ld\n, write returns %ld\n", myret, exret);
}

void	test_strlen(void)
{
	char *x;

	printf("\n-----strlen-----\n");
	x = "";
	printf("for `%s` ft_strlen returns %ld, strlen returns %ld\n", x, ft_strlen(x), strlen(x));
	x = "toto";
	printf("for `%s` ft_strlen returns %ld, strlen returns %ld\n", x, ft_strlen(x), strlen(x));
}

void	test_strdup(void)
{
	char *tmp;
	char *tmp2;

	# define DUP(s)	tmp = ft_strdup(s); printf("`%s` (`%s`)\n", tmp, s); free(tmp); tmp = NULL;

	printf("\n------strdup-----\n");
	tmp2 = ft_strdup("toto");
	int i = 0;
	while(tmp2[i])
		{printf("!%c\n", tmp2[i]);
		i++;}
	DUP(tmp2)
	free(tmp2);
	DUP("totobar")
	DUP("blablabla")
	DUP("")
}

void	test_strcpy(void)
{
	int		i;
	char	buffer[100];

	printf("\n-----strcpy-----\n");
	i = 0;
	while (i < 100)
		buffer[i++] = 0;
	printf("`%s` (`toto`)\n", ft_strcpy(buffer, "toto"));
	printf("`%s` (empty)\n", ft_strcpy(buffer, ""));
	printf("`%s` (`blablabla`)\n", ft_strcpy(buffer, "blablabla"));
}

void	test_strcmp(void)
{
	# define STRCMP(a, b)	printf("for `%s`:`%s` ft_strcmp returns %d, strcmp returns %d\n", a, b, ft_strcmp(a, b), strcmp(a, b));

	printf("\n-----strcmp-----\n");
	STRCMP("", "")
	STRCMP("toto", "toto")
	STRCMP("", "toto")
	STRCMP("toto", "")
	STRCMP("totoc", "totoaa")
	STRCMP("toto", "totr")
	STRCMP("toto\ndsdssd", "totr\n\rjsdbcsd")
}

int		main(void)
{
	test_read();
	test_write();
	test_strlen();
	test_strcpy();
	test_strdup();
	test_strcmp();
	return (0);
}