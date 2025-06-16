# configure.ac for Bitnion Core
# Replaces Bitcoin Core with Bitnion Core 100%

AC_PREREQ([2.69])
AC_INIT([bitnion], [1.0], [bitnion@gmail.com])
AC_CONFIG_SRCDIR([src/chainparams.cpp])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_HEADERS([src/config/bitnion-config.h])

AM_INIT_AUTOMAKE([foreign subdir-objects -Wall])
AC_CANONICAL_HOST

# Checks for programs
AC_PROG_CC
AC_PROG_CXX
AC_PROG_INSTALL
AC_PROG_MAKE_SET

# Compiler flags
AX_CXX_COMPILE_STDCXX(11, noext, mandatory)

# Required libraries
AC_CHECK_LIB([boost_system], [main], [], [AC_MSG_ERROR([Boost libraries not found])])
AC_CHECK_LIB([ssl], [SSL_library_init], [], [AC_MSG_ERROR([OpenSSL not found])])
AC_CHECK_LIB([event], [event_base_new], [], [AC_MSG_ERROR([libevent not found])])
PKG_CHECK_MODULES([ZMQ], [libzmq], [], [AC_MSG_WARN([ZeroMQ not found; ZMQ support disabled])])

# Optional GUI/Qt5 support
AC_ARG_ENABLE([gui],
  [AS_HELP_STRING([--enable-gui], [Enable Qt GUI [default=no]])],
  [enable_gui=$enableval], [enable_gui=no])
AM_CONDITIONAL([USE_QT], [test "x$enable_gui" = "xyes"])

# Output files
AC_CONFIG_FILES([
  Makefile
  src/Makefile
  doc/Makefile
  libbitnionconsensus.pc
])

# Display configuration summary
AC_OUTPUT

echo
echo "Bitnion Core Configuration Summary"
echo "----------------------------------"
echo "  Chain Parameters  : src/chainparams.cpp"
echo "  POW Logic         : src/pow.cpp"
echo "  Validation Logic  : src/validation.cpp"
echo "  Documentation     : README.md"
echo "  Qt GUI Support    : $enable_gui"
echo
echo "Configuration completed. Run ./configure then make"
