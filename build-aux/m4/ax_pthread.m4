dnl ==========================================================================
dnl  Bitnion M4 Macro to Detect POSIX Threads (pthread)
dnl ==========================================================================
dnl  AX_PTHREAD will define:
dnl    HAVE_PTHREAD   - if pthread is available
dnl    PTHREAD_CFLAGS - flags to add to CPPFLAGS or CXXFLAGS
dnl    PTHREAD_LIBS   - flags to add to LIBS

AC_DEFUN([AX_PTHREAD], [
  AC_REQUIRE([AC_CANONICAL_HOST])
  AC_LANG_PUSH([C])

  AC_MSG_CHECKING([for pthreads support])
  PTHREAD_LIBS=""
  PTHREAD_CFLAGS=""
  ax_pthread_ok=no

  for flag in "-pthread" "-lpthread"; do
    ax_pthread_save_CFLAGS="$CFLAGS"
    ax_pthread_save_LIBS="$LIBS"
    CFLAGS="$CFLAGS $flag"
    LIBS="$LIBS $flag"

    AC_LINK_IFELSE([
      AC_LANG_PROGRAM([[
        #include <pthread.h>
      ]], [[
        pthread_t t; pthread_create(&t, 0, 0, 0); pthread_join(t, 0);
      ]])
    ], [
      ax_pthread_ok=yes
      PTHREAD_CFLAGS="$flag"
      PTHREAD_LIBS="$flag"
      break
    ])

    CFLAGS="$ax_pthread_save_CFLAGS"
    LIBS="$ax_pthread_save_LIBS"
  done

  if test "x$ax_pthread_ok" = xyes; then
    AC_DEFINE([HAVE_PTHREAD], [1], [Define if pthreads are available])
    AC_SUBST([PTHREAD_CFLAGS])
    AC_SUBST([PTHREAD_LIBS])
    AC_MSG_RESULT([yes])
  else
    AC_MSG_ERROR([POSIX threads not found])
  fi

  AC_LANG_POP([C])
])
