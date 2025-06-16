dnl ==========================================================================
dnl  Bitnion M4 Macro to Check for GCC-style Function Attributes
dnl ==========================================================================
dnl  AX_GCC_FUNC_ATTRIBUTE([attribute], [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
dnl  Example usage: AX_GCC_FUNC_ATTRIBUTE([noreturn], [...], [...])

AC_DEFUN([AX_GCC_FUNC_ATTRIBUTE], [
  AC_PREREQ([2.64])
  AC_LANG_PUSH([C])
  AS_VAR_PUSHDEF([ac_var], [ax_cv_func_attribute_$1])
  AC_CACHE_CHECK([for __attribute__(($1))], [ac_var], [
    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
      #include <stdlib.h>
      static void __attribute__(($1)) mytest(void) {}
    ]], [[]])],
    [AS_VAR_SET([ac_var], [yes])],
    [AS_VAR_SET([ac_var], [no])]
  )])
  AS_IF([test AS_VAR_GET(ac_var) = yes], [
    AC_DEFINE_UNQUOTED(AS_TR_CPP([HAVE_FUNC_ATTRIBUTE_$1]), [1],
      [Define to 1 if the compiler supports __attribute__(($1))])
    $2
  ], [$3])
  AS_VAR_POPDEF([ac_var])
  AC_LANG_POP([C])
])
