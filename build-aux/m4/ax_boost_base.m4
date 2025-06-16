dnl ==========================================================================
dnl  Bitnion M4 Macro for Boost Base Detection (100% Bitcoin-compatible)
dnl ==========================================================================

AC_DEFUN([AX_BOOST_BASE], [
  AC_REQUIRE([AC_CANONICAL_HOST])

  AC_ARG_WITH([boost],
    [AS_HELP_STRING([--with-boost=PATH], [Root of Boost installation])],
    [BOOST_ROOT="$withval"],
    [BOOST_ROOT=""])

  AC_ARG_WITH([boost-libdir],
    [AS_HELP_STRING([--with-boost-libdir=LIB_DIR], [Directory where Boost libraries are])],
    [BOOST_LIBDIR="$withval"],
    [BOOST_LIBDIR=""])

  if test "$BOOST_ROOT" != ""; then
    BOOST_CPPFLAGS="-I$BOOST_ROOT/include"
    if test "$BOOST_LIBDIR" = ""; then
      BOOST_LDFLAGS="-L$BOOST_ROOT/lib"
    else
      BOOST_LDFLAGS="-L$BOOST_LIBDIR"
    fi
  fi

  CPPFLAGS_SAVED="$CPPFLAGS"
  LDFLAGS_SAVED="$LDFLAGS"
  CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
  LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"

  AC_LANG_PUSH([C++])
  AC_MSG_CHECKING([for Boost headers])

  AC_COMPILE_IFELSE([
    AC_LANG_PROGRAM([[#include <boost/version.hpp>]], [[return (BOOST_VERSION);]])
  ], [
    AC_MSG_RESULT([yes])
    AC_DEFINE([HAVE_BOOST], [1], [Define if Boost is available])
    found_boost="yes"
  ], [
    AC_MSG_RESULT([no])
    found_boost="no"
  ])

  AC_LANG_POP([C++])
  CPPFLAGS="$CPPFLAGS_SAVED"
  LDFLAGS="$LDFLAGS_SAVED"

  if test "$found_boost" != "yes"; then
    AC_MSG_ERROR([Boost headers not found. Please install Boost or use --with-boost option.])
  fi
])
