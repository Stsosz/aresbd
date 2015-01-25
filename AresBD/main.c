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
    int connectPort = 2222;
    int index;
    int c;
    int displayHelp = 0;
    
    opterr = 0;
    while ((c = getopt (argc, argv, "s b p:")) != -1)
        switch (c)
    {
        case 's':
            openShell = 1;
            break;
        case 'h':
            displayHelp = 1;
            break;
        case 'b':
            bflag = 1;
            break;
        case 'p':
            connectPort = atoi(optarg);
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
    printf ("Connection = %d, bflag = %d, Port = %d\n", openShell, bflag, connectPort);

    for (index = optind; index < argc; index++)
        printf ("Non-option argument %s\n", argv[index]);
    return 0;
    
    
}

