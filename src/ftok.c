#include <sys/types.h>
#include <sys/ipc.h>
#include <stdio.h>
#include <stdlib.h>

int
main (int argc, char** argv)
{
    if (argc != 3)
    {
        fprintf (stderr, "usage: ftok FILE ID\n");
        return 1;
    }
    printf ("%i\n", ftok (argv[1], atoi (argv[2])));
    return 0;
}
