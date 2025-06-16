dnl ==========================================================================
dnl  Bitnion M4 Macro for Boost Unit Test Framework (Boost.Test)
dnl ==========================================================================
dnl  Detects and configures support for Boost's unit testing framework.
dnl  Used for validating core logic, including consensus, POW, and validation.

AC_DEFUN([AX_BOOST_UNIT_TEST_FRAMEWORK], [
  AC_REQUIRE([AX_BOOST_BASE])
  AC_REQUIRE([AX_BOOST_SYSTEM])

  AC_LANG_PUSH([C++])
  AC_MSG_CHECKING([for Boost Unit Test Framework library])

  LIBS_SAVED="$LIBS"
  LIBS="$LIBS -lboost_unit_test_framework -lboost_system"

  AC_LINK_IFELSE([
    AC_LANG_PROGRAM([[
      #define BOOST_TEST_MODULE BitnionTest
      #include <boost/test/unit_test.hpp>
    ]], [[
      return boost::unit_test::framework::master_test_suite().argc;
    ]])
  ], [
    AC_MSG_RESULT([yes])
    AC_DEFINE([HAVE_BOOST_UNIT_TEST_FRAMEWORK], [1], [Define if Boost.Test is available])
  ], [
    AC_MSG_RESULT([no])
    AC_MSG_WARN([Boost.Test (Unit Test Framework) not found. Unit tests will not be built.])
  ])

  LIBS="$LIBS_SAVED"
  AC_LANG_POP([C++])
])
