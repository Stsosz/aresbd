//
//  main.c
//  AresBD
//
//  Created by Seamus Abergel-Preston on 2015-01-12.
//  Copyright (c) 2015 Stsosz Systems. All rights reserved.
//

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "main.h"

int main (int argc, char **argv)
{
    int openShell = 0;
    int bflag = 0;
    char *connectport = NULL;
    int index;
    int c;
    
    opterr = 0;
    while ((c = getopt (argc, argv, "s b p:")) != -1)
        switch (c)
    {
        case 's':
            
            /* This will open the Reverse TCP connection, almost like
            NetCat!*/
            
            // Le Code //
            
            openShell = 1;
            break;
            
        case 'h':
            
            // Help Dialog //
            
            printf("AresBD by Stsosz");
            
            break;
            
        case 'b':
            
            bflag = 1;
            
            break;
            
        case 'p':
            
            // Set Connection Port //
            
            connectport = optarg;
            
            break;
            
        case '?':
            if (optopt == 'c')
                fprintf (stderr, "Option -%c requires an argument.\n", optopt);
            
            else if (isprint (optopt))
                fprintf (stderr, "Unknown option `-%c'.\n", optopt);
            
            else
                fprintf (stderr,
                         "Unknown option character `\\x%x'.\n",
                         optopt);
            return 1;
        default:
            abort ();
    }
    printf ("Connection = %d, bflag = %d, Port = %s\n",
            openShell, bflag, connectport);

    for (index = optind; index < argc; index++)
        printf ("Non-option argument %s\n", argv[index]);
    return 0;
}

