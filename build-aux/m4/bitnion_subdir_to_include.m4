dnl ==========================================================================
dnl  Bitnion M4 Macro: Add source subdirectories to compiler include path
dnl ==========================================================================
dnl  Usage:
dnl    BITNION_SUBDIR_TO_INCLUDE([src])
dnl    BITNION_SUBDIR_TO_INCLUDE([src/wallet])
dnl    BITNION_SUBDIR_TO_INCLUDE([src/qt])
dnl  Adds the subdir to CPPFLAGS as -Isubdir

AC_DEFUN([BITNION_SUBDIR_TO_INCLUDE], [
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_PROG_CPP])

  AC_MSG_CHECKING([whether subdir $1 should be included in compiler search path])
  if test -d "$srcdir/$1"; then
    AC_MSG_RESULT([yes])
    CPPFLAGS="$CPPFLAGS -I\$(top_srcdir)/$1"
  else
    AC_MSG_RESULT([no])
  fi
])
