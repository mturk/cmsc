/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is originates from the w64 mingw-runtime package.
 */

#if     _MSC_VER > 1000
#pragma once
#endif

#ifndef _INC_STAT
#define _INC_STAT

#if     !defined(_WIN32)
#error ERROR: Only Win32 target supported!
#endif

#include <crtdefs.h>


#ifdef  _MSC_VER
#pragma pack(push,_CRT_PACKING)
#endif  /* _MSC_VER */

#ifdef  __cplusplus
extern "C" {
#endif


#include <sys/types.h>

#ifdef _USE_32BIT_TIME_T
#ifdef _WIN64
#undef _USE_32BIT_TIME_T
#endif
#endif

#ifndef _TIME32_T_DEFINED
typedef long __time32_t;
#define _TIME32_T_DEFINED
#endif

#ifndef _TIME64_T_DEFINED
typedef __int64 __time64_t;
#define _TIME64_T_DEFINED
#endif

#ifndef _TIME_T_DEFINED
#ifdef _USE_32BIT_TIME_T
typedef __time32_t time_t;
#else
typedef __time64_t time_t;
#endif
#define _TIME_T_DEFINED
#endif

#if !defined(_WCHAR_T_DEFINED) && !defined(_NATIVE_WCHAR_T_DEFINED)
typedef unsigned short wchar_t;
#define _WCHAR_T_DEFINED
#endif

#ifndef _STAT_DEFINED

/*
 * The structure manipulated and returned by stat and fstat.
 *
 * NOTE: If called on a directory the values in the time fields are not only
 * invalid, they will cause localtime et. al. to return NULL. And calling
 * asctime with a NULL pointer causes an Invalid Page Fault. So watch it!
 */
struct _stat
{
    _dev_t  st_dev;     /* Equivalent to drive number 0=A 1=B ... */
    _ino_t  st_ino;     /* Always zero ? */
    unsigned short st_mode;    /* See above constants */
    short   st_nlink;   /* Number of links. */
    short   st_uid;     /* User: Maybe significant on NT ? */
    short   st_gid;     /* Group: Ditto */
    _dev_t  st_rdev;    /* Seems useless (not even filled in) */
    _off_t  st_size;    /* File size in bytes */
    time_t  st_atime;   /* Accessed date (always 00:00 hrs local * on FAT) */
    time_t  st_mtime;   /* Modified time */
    time_t  st_ctime;   /* Creation time */
};

struct _stati64 {
    _dev_t st_dev;
    _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    __int64 st_size;
    time_t st_atime;
    time_t st_mtime;
    time_t st_ctime;
};

struct _stat32 {
    _dev_t st_dev;
    _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    _off_t st_size;
    __time32_t st_atime;
    __time32_t st_mtime;
    __time32_t st_ctime;
};

struct _stat32i64 {
    _dev_t st_dev;
    _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    __int64 st_size;
    __time32_t st_atime;
    __time32_t st_mtime;
    __time32_t st_ctime;
};

struct _stat64i32 {
    _dev_t st_dev;
    _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    _off_t st_size;
    __time64_t st_atime;
    __time64_t st_mtime;
    __time64_t st_ctime;
};

struct __stat64 {
    _dev_t st_dev;
    _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    __int64 st_size;
    __time64_t st_atime;
    __time64_t st_mtime;
    __time64_t st_ctime;
};

#define stat64   _stat64  /* for POSIX */
#define fstat64  _fstat64 /* for POSIX */

/* Non-ANSI names for compatibility */
struct stat {
    _dev_t     st_dev;
    _ino_t     st_ino;
    unsigned short st_mode;
    short      st_nlink;
    short      st_uid;
    short      st_gid;
    _dev_t     st_rdev;
    _off_t     st_size;
    time_t st_atime;
    time_t st_mtime;
    time_t st_ctime;
};

#define _STAT_DEFINED
#endif /* _STAT_DEFINED */

#define _S_IFMT         0xF000          /* file type mask */
#define _S_IFDIR        0x4000          /* directory */
#define _S_IFCHR        0x2000          /* character special */
#define _S_IFIFO        0x1000          /* pipe */
#define _S_IFREG        0x8000          /* regular */
#define _S_IREAD        0x0100          /* read permission, owner */
#define _S_IWRITE       0x0080          /* write permission, owner */
#define _S_IEXEC        0x0040          /* execute/search permission, owner */


/* Function prototypes */
_CRTIMP int __cdecl _fstat(int, struct _stat *);
_CRTIMP int __cdecl _fstat64(int, struct __stat64 *);
_CRTIMP int __cdecl _fstati64(int, struct _stati64 *);
_CRTIMP int __cdecl _stat(const char *, struct _stat *);
_CRTIMP int __cdecl _stat64(const char *, struct __stat64 *);
_CRTIMP int __cdecl _stati64(const char *, struct _stati64 *);

#ifndef _WSTAT_DEFINED

/* wide function prototypes, also declared in wchar.h  */

_CRTIMP int __cdecl _wstat(const wchar_t *, struct _stat *);
_CRTIMP int __cdecl _wstat64(const wchar_t *, struct __stat64 *);
_CRTIMP int __cdecl _wstati64(const wchar_t *, struct _stati64 *);
#define _WSTAT_DEFINED
#endif


#if     !__STDC__

/* Non-ANSI names for compatibility */

#define S_IFMT   _S_IFMT
#define S_IFDIR  _S_IFDIR
#define S_IFCHR  _S_IFCHR
#define S_IFREG  _S_IFREG
#define S_IREAD  _S_IREAD
#define S_IWRITE _S_IWRITE
#define S_IEXEC  _S_IEXEC

#endif  /* __STDC__ */

/*
 * This file is included for __inlined non stdc functions. i.e. stat and fstat
 */
#if !defined(RC_INVOKED) && !defined(__midl)
#include <sys/stat.inl>
#endif

#ifdef  __cplusplus
}
#endif

#ifdef  _MSC_VER
#pragma pack(pop)
#endif  /* _MSC_VER */

#endif  /* _INC_STAT */
