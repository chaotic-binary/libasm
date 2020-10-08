
#include "libasm.h"
#include <string.h>
#include <stdio.h>
#include <fcntl.h>

static void	test_write(void)
{
	long	myret;
	long	expret;
	int		fd;

	# define WRITE(myret, expret)	printf("ft_write returns %ld, expected %ld\n", myret, expret);

	printf("\n-----write-----\n");
	myret = ft_write(1, "toto\n", 5);
	expret = write(1, "toto\n", 5);
	if (myret != expret)
		WRITE(myret, expret);

	myret = ft_write(1, "to\nto", 3);
	expret = write(1, "to\nto", 3);
	if (myret != expret)
		WRITE(myret, expret);

	myret = ft_write(1, NULL, 4);
	expret = write(1, NULL, 4);
	if (myret != expret)
		WRITE(myret, expret);

	errno = 0;
	myret = ft_write(-1, "toto", 4);
	printf("for fd -1 ft_write errno = %d\n", errno);
	expret = write(-1, "toto", 4);
	printf("for fd -1 expected errno = %d\n", errno);
	if (myret != expret)
		WRITE(myret, expret);

	errno = 0;
	fd = open("test.txt", O_CREAT | O_APPEND | O_WRONLY, 0755);
	ft_write(fd, "   Look at the file and find ", 29);
	printf("ft_write errno = %d\n", errno);
	write(fd, "that I can write ", 17);
	printf("expected errno = %d, test.txt should be created\n", errno);
	close(fd);

	errno = 0;
	fd = open("test.txt", O_WRONLY);
	ft_write(fd, "!", 1);
	printf("ft_write errno = %d\n", errno);
	write(fd, "?", 1);
	printf("expected errno = %d, test.txt should be updated\n", errno);
	close(fd);

	myret = ft_write(3,"toto", 4);
	expret = write(3,"toto", 4);
	if (myret != expret)
		WRITE(myret, expret);
	myret = ft_write(3,"toto", 0);
	expret = write(3,"toto", 0);
	if (myret != expret)
		WRITE(myret, expret);
}

static void	test_read(void)
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

static void	test_strlen(void)
{
	char *x;

	printf("\n-----strlen-----\n");
	x = "";
	printf("for `%s` ft_strlen returns %ld, strlen returns %ld\n", x, ft_strlen(x), strlen(x));
	x = "toto";
	printf("for `%s` ft_strlen returns %ld, strlen returns %ld\n", x, ft_strlen(x), strlen(x));
}

static void	test_strdup(void)
{
	char *tmp;
	char *str;
	int		i;

	# define STRDUP(s)	tmp = ft_strdup(s); printf("`%s` is a copy of `%s`\n", tmp, s); free(tmp); tmp = NULL;

	printf("\n------strdup-----\n");
	str = ft_strdup("meow");
	i = 0;
	while(str[i])
	{
		printf("!%c\n", str[i]);
		i++;
	}
	STRDUP(str)
	free(str);
	STRDUP("?     !")
	STRDUP("blablabla")
	STRDUP("")
}

static void	test_strcpy(void)
{
	int		i;
	char	buffer[100];
	char	*str;

	printf("\n-----strcpy-----\n");
	i = 0;
	while (i < 100)
		buffer[i++] = 0;
	str = ft_strcpy(buffer, "meow");
	i = 0;
	while(str[i])
	{
		printf("!%c\n", str[i]);
		i++;
	}
	printf("`%s` is a copy of `meow`\n", ft_strcpy(buffer, "meow"));
	printf("`%s` is a copy of an empty str\n", ft_strcpy(buffer, ""));
	printf("`%s` is a copy of `long string`\n", ft_strcpy(buffer, "long string"));
}

static void	test_strcmp(void)
{
	# define STRCMP(a, b)	(ft_strcmp(a, b) > 0 == strcmp(a, b) > 0) ? printf("OK for `%s`:`%s`\n", a, b) : printf("for `%s`:`%s` ft_strcmp returns %d, strcmp returns %d\n", a, b, ft_strcmp(a, b), strcmp(a, b));

	printf("\n-----strcmp-----\n");
	STRCMP("", "")
	STRCMP("toto", "toto")
	STRCMP("", "toto")
	STRCMP("toto", "")
	STRCMP("totoc", "totoaa")
	STRCMP("toto", "totr")
	STRCMP("to", "toto")
	STRCMP("o\nkgfkg", "r\n\rfgnkfgk")
}

int		main(void)
{
	test_strcmp();
	test_strcpy();
	test_strdup();
	test_strlen();
	test_write();
	test_read();
	return (0);
}
