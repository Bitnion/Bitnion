#ifndef BITNION_LIBSECP256K1_CONFIG_H
#define BITNION_LIBSECP256K1_CONFIG_H

/* Define to 1 if the system has the type `__int128'. */
#undef HAVE___INT128

/* Define to 1 if the system has the type `unsigned __int128'. */
#undef HAVE_UNSIGNED___INT128

/* Define to 1 if you have the `builtin_expect' built-in. */
#undef HAVE_BUILTIN_EXPECT

/* Define to 1 if the compiler supports __builtin_popcount. */
#undef HAVE_BUILTIN_POPCOUNT

/* Define to 1 if the compiler supports __builtin_clz. */
#undef HAVE_BUILTIN_CLZ

/* Define to 1 if the compiler supports __builtin_ctz. */
#undef HAVE_BUILTIN_CTZ

/* Define this symbol if an __int128 type is available */
#define USE_SCALAR_4X64 1

/* Define this symbol to compile the module with endomorphism support */
#undef USE_ENDOMORPHISM

/* Define this symbol to compile with field_10x26 implementation */
#undef USE_FIELD_10X26

/* Define this symbol to compile with field_5x52 implementation */
#define USE_FIELD_5X52 1

/* Define to use the x86_64 64-bit optimized implementation */
#define USE_NUM_GMP 0
#define USE_NUM_NONE 1

/* Use the default implementation for scalar arithmetic */
#define USE_SCALAR_8X32 1

/* Endianess: Define if building for big endian */
#undef WORDS_BIGENDIAN

/* Do not use OpenSSL */
#define USE_EXTERNAL_DEFAULT_CALLBACKS 1

/* Optional: define if building in a restricted environment */
#undef ENABLE_MODULE_RECOVERY
#undef ENABLE_MODULE_ECDH

#endif // BITNION_LIBSECP256K1_CONFIG_H
