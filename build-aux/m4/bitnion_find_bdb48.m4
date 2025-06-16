dnl ==========================================================================
dnl  Bitnion M4 Macro to Detect Berkeley DB 4.8 (for wallet support)
dnl ==========================================================================
dnl  Provides:
dnl    BDB_CFLAGS
dnl    BDB_LIBS
dnl    HAVE_BDB
dnl  Based on detection logic from Bitcoin Core, renamed for Bitnion

AC_DEFUN([BITNION_FIND_BDB48], [
  AC_ARG_WITH([bdb],
    [AS_HELP_STRING([--with-bdb=PATH], [Path to Berkeley DB 4.8])],
    [use_bdb_path="$withval"], [use_bdb_path=""])

  if test "x$use_bdb_path" != "x"; then
    BDB_CPPFLAGS="-I$use_bdb_path/include"
    BDB_LDFLAGS="-L$use_bdb_path/lib"
  else
    BDB_CPPFLAGS=""
    BDB_LDFLAGS=""
  fi

  CPPFLAGS_SAVED="$CPPFLAGS"
  LDFLAGS_SAVED="$LDFLAGS"
  CPPFLAGS="$CPPFLAGS $BDB_CPPFLAGS"
  LDFLAGS="$LDFLAGS $BDB_LDFLAGS"

  AC_LANG_PUSH([C++])
  AC_MSG_CHECKING([for Berkeley DB 4.8])
  AC_COMPILE_IFELSE([
    AC_LANG_PROGRAM([[
      #include <db_cxx.h>
    ]], [[
      DbEnv env(DB_CXX_NO_EXCEPTIONS);
    ]])
  ], [
    AC_MSG_RESULT([yes])
    AC_DEFINE([HAVE_BDB], [1], [Define if Berkeley DB is available])
    BDB_CFLAGS="$BDB_CPPFLAGS"
    BDB_LIBS="$BDB_LDFLAGS -ldb_cxx-4.8"
  ], [
    AC_MSG_RESULT([no])
    AC_MSG_ERROR([Berkeley DB 4.8 not found. Use --with-bdb=PATH to specify location.])
  ])
  AC_LANG_POP([C++])

  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"

  AC_SUBST([BDB_CFLAGS])
  AC_SUBST([BDB_LIBS])
])
