dnl ==========================================================================
dnl  Bitnion M4 Macro to Check Compiler Support for a Given Compile Flag
dnl ==========================================================================
dnl  AX_CHECK_COMPILE_FLAG([flag], [action-if-found], [action-if-not-found])
dnl  Based on autotools best practices (like used in Bitcoin Core)

AC_DEFUN([AX_CHECK_COMPILE_FLAG], [
  AC_PREREQ([2.64])
  AC_LANG_PUSH([C++])
  AS_VAR_PUSHDEF([ac_var], [ax_cv_check_compile_flag_$1])
  AC_CACHE_CHECK([whether $CXX supports $1], [ac_var], [
    ac_save_CXXFLAGS="$CXXFLAGS"
    CXXFLAGS="$CXXFLAGS $1"
    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([], [])],
      [AS_VAR_SET([ac_var], [yes])],
      [AS_VAR_SET([ac_var], [no])]
    )
    CXXFLAGS="$ac_save_CXXFLAGS"
  ])
  AS_IF([test AS_VAR_GET(ac_var) = yes], [$2], [$3])
  AS_VAR_POPDEF([ac_var])
  AC_LANG_POP([C++])
])
