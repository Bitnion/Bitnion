dnl ==========================================================================
dnl  Bitnion M4 Macro: Check whether linking with -latomic is needed
dnl ==========================================================================
dnl  Defines:
dnl    NEED_LD_ATOMIC     - if set, means -latomic must be linked
dnl    LD_ATOMIC_LIBS     - holds -latomic if needed
dnl
dnl  This is necessary for platforms where atomic built-ins require -latomic

AC_DEFUN([BITNION_CHECK_LDFLAG_ATOMIC], [
  AC_LANG_PUSH([C++])
  AC_MSG_CHECKING([whether linking with -latomic is needed])

  AC_LINK_IFELSE([
    AC_LANG_PROGRAM([[
      #include <atomic>
      std::atomic<int> test_atomic(0);
    ]], [[
      ++test_atomic;
    ]])
  ], [
    AC_MSG_RESULT([no])
    NEED_LD_ATOMIC=no
    LD_ATOMIC_LIBS=""
  ], [
    OLD_LIBS="$LIBS"
    LIBS="$LIBS -latomic"
    AC_LINK_IFELSE([
      AC_LANG_PROGRAM([[
        #include <atomic>
        std::atomic<int> test_atomic(0);
      ]], [[
        ++test_atomic;
      ]])
    ], [
      AC_MSG_RESULT([yes])
      NEED_LD_ATOMIC=yes
      LD_ATOMIC_LIBS="-latomic"
    ], [
      AC_MSG_RESULT([failed])
      AC_MSG_ERROR([Linking atomic operations failed, even with -latomic])
    ])
    LIBS="$OLD_LIBS"
  ])

  AC_SUBST([LD_ATOMIC_LIBS])
  AC_LANG_POP([C++])
])
