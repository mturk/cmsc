/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file originates from the w64 mingw-runtime package.
 */

#if     _MSC_VER > 1000
#pragma once
#endif

#include <crtdefs.h>

#ifndef _INC_STAT_INL
#define _INC_STAT_INL

static __inline int __cdecl _fstat32(int _Desc, struct _stat32 *_Stat)
{
    struct _stati64 st;
    int ret = _fstati64(_Desc, &st);
    if (ret == -1) {
        memset(_Stat, 0 ,sizeof(struct _stat32));
        return -1;
    }
    _Stat->st_dev = st.st_dev;
    _Stat->st_ino = st.st_ino;
    _Stat->st_mode = st.st_mode;
    _Stat->st_nlink = st.st_nlink;
    _Stat->st_uid = st.st_uid;
    _Stat->st_gid = st.st_gid;
    _Stat->st_rdev = st.st_rdev;
    _Stat->st_size = (_off_t)st.st_size;
    _Stat->st_atime = (__time32_t)st.st_atime;
    _Stat->st_mtime = (__time32_t)st.st_mtime;
    _Stat->st_ctime = (__time32_t)st.st_ctime;
    return ret;
}
static __inline int __cdecl _stat32(const char *_Filename, struct _stat32 *_Stat)
{
    struct _stati64 st;
    int ret = _stati64(_Filename, &st);
    if (ret == -1) {
        memset(_Stat, 0, sizeof(struct _stat32));
        return -1;
    }
    _Stat->st_dev = st.st_dev;
    _Stat->st_ino = st.st_ino;
    _Stat->st_mode = st.st_mode;
    _Stat->st_nlink = st.st_nlink;
    _Stat->st_uid = st.st_uid;
    _Stat->st_gid = st.st_gid;
    _Stat->st_rdev = st.st_rdev;
    _Stat->st_size = (_off_t)st.st_size;
    _Stat->st_atime = (__time32_t)st.st_atime;
    _Stat->st_mtime = (__time32_t)st.st_mtime;
    _Stat->st_ctime = (__time32_t)st.st_ctime;
    return ret;
}

#ifdef _USE_32BIT_TIME_T
static __inline int __cdecl fstat(int _Desc, struct stat *_Stat)
{
    struct _stat32 st;
    int ret = _fstat32(_Desc,&st);
    if (ret == -1) {
        memset(_Stat,0,sizeof(struct stat));
        return -1;
    }
    /* struct stat and struct _stat32
     * are the same for this case.
     */
    memcpy(_Stat, &st, sizeof(struct _stat32));
    return ret;
}

static __inline int __cdecl stat(const char *_Filename, struct stat *_Stat)
{
    struct _stat32 st;
    int ret = _stat32(_Filename, &st);
    if (ret == -1) {
        memset(_Stat, 0, sizeof(struct stat));
        return -1;
    }
    /* struct stat and struct _stat32
     * are the same for this case.
     */
    memcpy(_Stat, &st, sizeof(struct _stat32));
    return ret;
}
#else
static __inline int __cdecl fstat(int _Desc, struct stat *_Stat)
{
    struct _stat64 st;
    int ret = _fstat64(_Desc, &st);
    if (ret == -1) {
        memset(_Stat, 0 ,sizeof(struct stat));
        return -1;
    }
    /* struct stat and struct _stat64i32
     * are the same for this case.
     */
    _Stat->st_dev = st.st_dev;
    _Stat->st_ino = st.st_ino;
    _Stat->st_mode = st.st_mode;
    _Stat->st_nlink = st.st_nlink;
    _Stat->st_uid = st.st_uid;
    _Stat->st_gid = st.st_gid;
    _Stat->st_rdev = st.st_rdev;
    _Stat->st_size = (_off_t)st.st_size;
    _Stat->st_atime = st.st_atime;
    _Stat->st_mtime = st.st_mtime;
    _Stat->st_ctime = st.st_ctime;
    return ret;
}
static __inline int __cdecl stat(const char *_Filename, struct stat *_Stat)
{
    struct _stat64 st;
    int ret = _stat64(_Filename, &st);
    if (ret == -1) {
        memset(_Stat, 0, sizeof(struct stat));
        return -1;
    }
    /* struct stat and struct _stat64i32
      * are the same for this case.
      */
    _Stat->st_dev = st.st_dev;
    _Stat->st_ino = st.st_ino;
    _Stat->st_mode = st.st_mode;
    _Stat->st_nlink = st.st_nlink;
    _Stat->st_uid = st.st_uid;
    _Stat->st_gid = st.st_gid;
    _Stat->st_rdev = st.st_rdev;
    _Stat->st_size = (_off_t)st.st_size;
    _Stat->st_atime = st.st_atime;
    _Stat->st_mtime = st.st_mtime;
    _Stat->st_ctime = st.st_ctime;
    return ret;
}
#endif /* _USE_32BIT_TIME_T */
#endif
