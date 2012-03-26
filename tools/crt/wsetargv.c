/***
*wsetargv.c - generic _wsetargv routine
*
*       Copyright (c) 1989-2001, Microsoft Corporation. All rights reserved.
*
*Purpose:
*       Linking in this module replaces the normal wsetargv with the
*       wildcard wsetargv.
*
*******************************************************************************/

#include <crtdefs.h>

int  __cdecl __setargv(void);           /* stdargv.c */
int  __cdecl __wsetargv(void);          /* wstdargv.c */

int __cdecl _wsetargv (void)
{
        return __wsetargv();
}
