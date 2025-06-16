dnl ==========================================================================
dnl  Bitnion M4 Macro for Boost Filesystem Detection (100% Bitcoin-compatible)
dnl ==========================================================================

AC_DEFUN([AX_BOOST_FILESYSTEM], [
  AC_REQUIRE([AX_BOOST_BASE])

  AC_LANG_PUSH([C++])
  AC_MSG_CHECKING([for Boost.Filesystem library])

  LIBS_SAVED="$LIBS"
  LIBS="$LIBS -lboost_filesystem -lboost_system"

  AC_LINK_IFELSE([
    AC_LANG_PROGRAM([[
      #include <boost/filesystem.hpp>
    ]], [[
      boost::filesystem::path path(".");
    ]])
  ], [
    AC_MSG_RESULT([yes])
    AC_DEFINE([HAVE_BOOST_FILESYSTEM], [1], [Define if Boost.Filesystem is available])
  ], [
    AC_MSG_RESULT([no])
    AC_MSG_ERROR([Boost.Filesystem library not found. Make sure Boost is installed with filesystem component.])
  ])

  LIBS="$LIBS_SAVED"
  AC_LANG_POP([C++])
])
