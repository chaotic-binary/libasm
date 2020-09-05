#ifndef LIBASM_H
# define LIBASM_H

# include <unistd.h>
# include <stdlib.h>
# include <errno.h>

ssize_t				ft_write(int fd, const char *buf, size_t count);
ssize_t				ft_read(int fd, void *buf, size_t count);
size_t				ft_strlen(const char *s);
char				*ft_strcpy(char *dest, const char *src);
char				*ft_strdup(const char *s);
int					ft_strcmp(const char *s1, const char *s2);

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

void		ft_list_push_front(t_list **begin_list, void *data);
void		ft_list_sort(t_list **begin_list, int (*cmp)());
void		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());
int			ft_list_size(t_list *begin_list);
int			ft_atoi_base(char *str, int base);

#endif