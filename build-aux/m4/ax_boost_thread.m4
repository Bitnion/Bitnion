dnl ==========================================================================
dnl  Bitnion M4 Macro for Boost.Thread Detection (Required for concurrency)
dnl ==========================================================================
dnl  Boost.Thread enables multithreading support for Bitnion components.
dnl  This macro verifies that Boost.Thread and its dependencies are linkable.

AC_DEFUN([AX_BOOST_THREAD], [
  AC_REQUIRE([AX_BOOST_BASE])
  AC_REQUIRE([AX_BOOST_SYSTEM]) dnl Boost.Thread depends on Boost.System

  AC_LANG_PUSH([C++])
  AC_MSG_CHECKING([for Boost.Thread library])

  LIBS_SAVED="$LIBS"
  LIBS="$LIBS -lboost_thread -lboost_system"

  AC_LINK_IFELSE([
    AC_LANG_PROGRAM([[
      #include <boost/thread.hpp>
    ]], [[
      boost::thread t([](){});
      t.join();
    ]])
  ], [
    AC_MSG_RESULT([yes])
    AC_DEFINE([HAVE_BOOST_THREAD], [1], [Define if Boost.Thread is available])
  ], [
    AC_MSG_RESULT([no])
    AC_MSG_ERROR([Boost.Thread library not found. Please install libboost-thread-dev or equivalent.])
  ])

  LIBS="$LIBS_SAVED"
  AC_LANG_POP([C++])
])
