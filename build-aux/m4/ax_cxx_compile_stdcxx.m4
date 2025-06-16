dnl ==========================================================================
dnl  Bitnion M4 Macro to Detect Supported C++ Standard (e.g., C++17)
dnl ==========================================================================
dnl  AX_CXX_COMPILE_STDCXX([version], [ext|noext], [mandatory|optional])
dnl  Based on AX_CXX_COMPILE_STDCXX macro from autoconf-archive

AC_DEFUN([AX_CXX_COMPILE_STDCXX], [
  AC_PREREQ([2.64])
  m4_if([$1], [11], [ax_cxx_compile_alternatives="c++11"],
        [$1], [14], [ax_cxx_compile_alternatives="c++14"],
        [$1], [17], [ax_cxx_compile_alternatives="c++17"],
        [$1], [20], [ax_cxx_compile_alternatives="c++20"],
        [m4_fatal([unsupported C++ standard version: $1])])

  AC_LANG_PUSH([C++])
  AC_MSG_CHECKING([for $ax_cxx_compile_alternatives support])

  ax_cxx_compile_flags=""
  for flag in "-std=$ax_cxx_compile_alternatives" "-std=gnu$ax_cxx_compile_alternatives"; do
    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([], [])], [
      ax_cxx_compile_flags="$flag"
      break
    ], [
      CXXFLAGS="$CXXFLAGS $flag"
      AC_COMPILE_IFELSE([AC_LANG_PROGRAM([], [])], [
        ax_cxx_compile_flags="$flag"
        break
      ])
    ])
  done

  if test "x$ax_cxx_compile_flags" = "x"; then
    if test "x$3" = "xmandatory"; then
      AC_MSG_ERROR([Compiler does not support -std=c++$1])
    else
      AC_MSG_WARN([Compiler does not support -std=c++$1, continuing anyway])
    fi
  else
    CXXFLAGS="$CXXFLAGS $ax_cxx_compile_flags"
    AC_MSG_RESULT([using $ax_cxx_compile_flags])
  fi
  AC_LANG_POP([C++])
])
