/***
*commode.c - set global file commit mode to commit
*
*       Copyright (c) 1990-2001, Microsoft Corporation. All rights reserved.
*
*Purpose:
*       Sets the global file commit mode flag to commit.  Linking with
*       this file sets all files to be opened in commit mode by default.
*
*******************************************************************************/

#define _IOCOMMIT       0x4000

/* set default file commit mode to commit */
int _commode = _IOCOMMIT;

