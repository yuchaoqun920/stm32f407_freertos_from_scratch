//
// Created by yuchaoqun on 2018/9/8.
//


#include <sys/stat.h>
#include <stdlib.h>
#include <errno.h>
#include <stdio.h>

#undef errno
extern int errno;

register char * stack_ptr asm("sp");

char *__env[1] = { 0 };
char **environ = __env;

extern int __io_putchar(int ch);

int _write(int file, char *ptr, int len)
{
    int todo;

    for (todo = 0; todo < len; todo++)
    {
        __io_putchar( *ptr++ );
    }

    /* Implement your write code here, this is used by puts and printf for example */
    return len;
}

#if 0
caddr_t _sbrk(int incr)
{
    extern char end asm("end");
    static char *heap_end;
    char *prev_heap_end;

    if (heap_end == 0)
        heap_end = &end;

    prev_heap_end = heap_end;
    if (heap_end + incr > stack_ptr)
    {
//		write(1, "Heap and stack collision\n", 25);
//		abort();
        errno = ENOMEM;
        return (caddr_t) -1;
    }

    heap_end += incr;

    return (caddr_t) prev_heap_end;
}
#endif

extern int  __HEAP_START;
caddr_t _sbrk ( int incr ){
    static unsigned char *heap = NULL;
    unsigned char *prev_heap;

    if (heap == NULL) {
        heap = (unsigned char *)&__HEAP_START;
    }
    prev_heap = heap;

    heap += incr;

    return (caddr_t) prev_heap;

}

int _close(int file)
{
    return -1;
}


int _fstat(int file, struct stat *st)
{
    st->st_mode = S_IFCHR;
    return 0;
}

int _isatty(int file)
{
    return 1;
}

int _lseek(int file, int ptr, int dir)
{
    return 0;
}

int _read(int file, char *ptr, int len)
{
    return 0;
}

int _open(char *path, int flags, ...)
{
    /* Pretend like we always fail */
    return -1;
}