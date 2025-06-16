dnl ==========================================================================
dnl  Bitnion M4 Macro for Boost.System Detection (Required for many components)
dnl ==========================================================================
dnl  Boost.System is a core dependency required by Boost.Filesystem,
dnl  Boost.Process, and other boost-based modules used in Bitnion.

AC_DEFUN([AX_BOOST_SYSTEM], [
  AC_REQUIRE([AX_BOOST_BASE])

  AC_LANG_PUSH([C++])
  AC_MSG_CHECKING([for Boost.System library])

  LIBS_SAVED="$LIBS"
  LIBS="$LIBS -lboost_system"

  AC_LINK_IFELSE([
    AC_LANG_PROGRAM([[
      #include <boost/system/error_code.hpp>
    ]], [[
      boost::system::error_code ec;
      ec.clear();
    ]])
  ], [
    AC_MSG_RESULT([yes])
    AC_DEFINE([HAVE_BOOST_SYSTEM], [1], [Define if Boost.System is available])
  ], [
    AC_MSG_RESULT([no])
    AC_MSG_ERROR([Boost.System library not found. Please install libboost-system-dev or equivalent.])
  ])

  LIBS="$LIBS_SAVED"
  AC_LANG_POP([C++])
])
