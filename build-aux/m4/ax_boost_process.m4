dnl ==========================================================================
dnl  Bitnion M4 Macro for Boost.Process Detection (Optional, modern Boost)
dnl ==========================================================================
dnl  This macro detects the Boost.Process library.
dnl  It is optional, but allows subprocess control if used in extensions.

AC_DEFUN([AX_BOOST_PROCESS], [
  AC_REQUIRE([AX_BOOST_BASE])

  AC_LANG_PUSH([C++])
  AC_MSG_CHECKING([for Boost.Process library])

  LIBS_SAVED="$LIBS"
  LIBS="$LIBS -lboost_process -lboost_system"

  AC_LINK_IFELSE([
    AC_LANG_PROGRAM([[
      #include <boost/process.hpp>
      namespace bp = boost::process;
    ]], [[
      bp::child c("echo Bitnion");
    ]])
  ], [
    AC_MSG_RESULT([yes])
    AC_DEFINE([HAVE_BOOST_PROCESS], [1], [Define if Boost.Process is available])
  ], [
    AC_MSG_RESULT([no])
    AC_MSG_WARN([Boost.Process not found. Optional features depending on process control may be disabled.])
  ])

  LIBS="$LIBS_SAVED"
  AC_LANG_POP([C++])
])
