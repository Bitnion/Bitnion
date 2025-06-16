dnl ==========================================================================
dnl  Bitnion M4 Macro to Detect and Configure Qt5 for GUI Build
dnl ==========================================================================
dnl  Provides:
dnl    QT_INCLUDES, QT_LIBS, HAVE_QT, QT_VERSION, ENABLE_QT

AC_DEFUN([BITNION_QT], [
  AC_ARG_ENABLE([qt],
    [AS_HELP_STRING([--enable-qt], [Build Bitnion with Qt GUI (default: yes)])],
    [use_qt="$enableval"], [use_qt="yes"])

  if test "x$use_qt" != "xno"; then
    AC_PATH_PROG([PKG_CONFIG], [pkg-config], [no])
    if test "x$PKG_CONFIG" = "xno"; then
      AC_MSG_ERROR([pkg-config is required to detect Qt libraries])
    fi

    AC_MSG_CHECKING([for Qt5Core >= 5.9])
    if $PKG_CONFIG --exists Qt5Core\ >=\ 5.9; then
      AC_MSG_RESULT([yes])
      QT_VERSION=$($PKG_CONFIG --modversion Qt5Core)
      QT_INCLUDES=$($PKG_CONFIG --cflags Qt5Core Qt5Widgets Qt5Gui)
      QT_LIBS=$($PKG_CONFIG --libs Qt5Core Qt5Widgets Qt5Gui Qt5Network Qt5DBus)

      AC_DEFINE([HAVE_QT], [1], [Define if Qt is available])
      AC_SUBST([QT_VERSION])
      AC_SUBST([QT_INCLUDES])
      AC_SUBST([QT_LIBS])
      ENABLE_QT="yes"
    else
      AC_MSG_RESULT([no])
      AC_MSG_ERROR([Qt5 >= 5.9 not found. You may disable Qt support with --disable-qt.])
    fi
  else
    ENABLE_QT="no"
  fi

  AM_CONDITIONAL([ENABLE_QT], [test "x$ENABLE_QT" = "xyes"])
])
