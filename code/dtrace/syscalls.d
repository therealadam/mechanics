syscall:::entry
/execname=="ruby"/
{
    printf("%s(%d) called %s\n", execname, pid, probefunc);
}

