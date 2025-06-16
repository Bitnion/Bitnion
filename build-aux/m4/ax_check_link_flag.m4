dnl ==========================================================================
dnl  Bitnion M4 Macro to Check Linker Flag Support (LDFLAGS)
dnl ==========================================================================
dnl  AX_CHECK_LINK_FLAG([flag], [action-if-found], [action-if-not-found])
dnl  Ensures flags like -Wl,--as-needed or -static are only added if supported.

AC_DEFUN([AX_CHECK_LINK_FLAG], [
  AC_PREREQ([2.64])
  AC_LANG_PUSH([C++])
  AS_VAR_PUSHDEF([ac_var], [ax_cv_check_link_flag_$1])
  AC_CACHE_CHECK([whether $CXX linker supports $1], [ac_var], [
    ac_save_LDFLAGS="$LDFLAGS"
    LDFLAGS="$LDFLAGS $1"
    AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])],
      [AS_VAR_SET([ac_var], [yes])],
      [AS_VAR_SET([ac_var], [no])]
    )
    LDFLAGS="$ac_save_LDFLAGS"
  ])
  AS_IF([test AS_VAR_GET(ac_var) = yes], [$2], [$3])
  AS_VAR_POPDEF([ac_var])
  AC_LANG_POP([C++])
])
