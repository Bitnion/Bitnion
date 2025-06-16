dnl ==========================================================================
dnl  Bitnion M4 Macro to Check Preprocessor Flag Support (CPPFLAGS)
dnl ==========================================================================
dnl  AX_CHECK_PREPROC_FLAG([flag], [action-if-found], [action-if-not-found])
dnl  Useful for detecting safe use of -DDEBUG, -DVERSION, -isystem, etc.

AC_DEFUN([AX_CHECK_PREPROC_FLAG], [
  AC_PREREQ([2.64])
  AC_LANG_PUSH([C++])
  AS_VAR_PUSHDEF([ac_var], [ax_cv_check_preproc_flag_$1])
  AC_CACHE_CHECK([whether $CXX preprocessor supports $1], [ac_var], [
    ac_save_CPPFLAGS="$CPPFLAGS"
    CPPFLAGS="$CPPFLAGS $1"
    AC_PREPROC_IFELSE([AC_LANG_PROGRAM([], [])],
      [AS_VAR_SET([ac_var], [yes])],
      [AS_VAR_SET([ac_var], [no])]
    )
    CPPFLAGS="$ac_save_CPPFLAGS"
  ])
  AS_IF([test AS_VAR_GET(ac_var) = yes], [$2], [$3])
  AS_VAR_POPDEF([ac_var])
  AC_LANG_POP([C++])
])
